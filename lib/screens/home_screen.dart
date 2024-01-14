import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler_new/models/HandlerLocation.dart';
import 'package:lemon_app_handler_new/states/storage_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lemon_app_handler_new/firebase_options.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lemon_app_handler_new/services/websocket_client.dart';
import 'package:location/location.dart';

import 'package:geolocator/geolocator.dart';

final webSocketClient = WebsocketClient();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String tokenFcmUser = "";
  String deviceId = "";
  var _isGettingLocation = false;
  HandlerLocation? handlerCurrentLocation;
  Timer? timer;

  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Get any messages which caused the application to open from
    // a terminated state.

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'help_request') {
      Navigator.pushNamed(context, 'Help');
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceId = androidDeviceInfo.id;
      });
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  void setupPushNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();
    final token = await fcm.getToken();
    setState(() {
      tokenFcmUser = token!;
    });
    debugPrint("fcm token: " + tokenFcmUser);
  }

  void _startWebSocket(String id) {
    // String rilDeviceId = deviceId!;
    debugPrint("deviceId: $id");

    webSocketClient.connect(
      "ws://192.168.139.122:8080/v1/ws?deviceId=$id",
      {
        'Authorization': 'Bearer ....',
      },
    );
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    _sendHandlerGeolocation(lat, lng);
  }

  _sendHandlerGeolocation(double lat, double long) {
    setState(() {
      handlerCurrentLocation = HandlerLocation(
          tokenFcm: tokenFcmUser, latitude: lat, longitude: long);
    });

    debugPrint(
        "longitude: " + long.toString() + " latitude: " + lat.toString());

    var payload = {
      'type': 'caregiver_location',
      'msg_geolocation_caregiver': handlerCurrentLocation!.toJson()
    };

    webSocketClient.send(jsonEncode(payload));
  }

  @override
  void initState() {
    setupInteractedMessage();
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification == null) return;
      showDialog(
          context: context,
          builder: (context) {
            return Material(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text(event.notification?.title ?? ''),
                            SizedBox(
                              height: 8,
                            ),
                            Text(event.notification?.body ?? ''),
                          ],
                        ))
                  ]),
            );
          });
    });
    super.initState();
    setupPushNotifications();

    _getId()!.then((id) {
      _startWebSocket(id!);
    });

    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => _getCurrentLocation());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          const Text(
            'Home Screen',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ref.watch(getAuthenticatedUserProvider).when(
                  loading: () => const CircularProgressIndicator(),
                  data: (email) => Text(email),
                  error: (error, stackTrace) {
                    debugPrint(error.toString());
                    return const Text('User information is not available!');
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isCleared = await ref.read(resetStorage);
          if (isCleared) {
            // ignore: use_build_context_synchronously
            Navigator.popAndPushNamed(context, 'Login');
          }
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}

// class HomeScreen extends HookConsumerWidget {
//   const HomeScreen({super.key});

// @override
// Widget build(BuildContext context, WidgetRef ref) {
//   return Scaffold(
//     body: Column(
//       children: [
//         const SizedBox(
//           height: 300,
//         ),
//         const Text(
//           'Home Screen',
//           style: TextStyle(
//             fontSize: 30,
//           ),
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         Center(
//           child: ref.watch(getAuthenticatedUserProvider).when(
//                 loading: () => const CircularProgressIndicator(),
//                 data: (email) => Text(email),
//                 error: (error, stackTrace) {
//                   debugPrint(error.toString());
//                   return const Text('User information is not available!');
//                 },
//               ),
//         ),
//       ],
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () async {
//         final isCleared = await ref.read(resetStorage);
//         if (isCleared) {
//           // ignore: use_build_context_synchronously
//           Navigator.popAndPushNamed(context, 'Login');
//         }
//       },
//       child: const Icon(Icons.delete),
//     ),
//   );
// }
// }
