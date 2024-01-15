import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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

  static double latitude = -7.797068;
  static double longitude = 110.370529;

  Set<Marker> _markers = Set<Marker>();

  Completer<GoogleMapController> _controller = Completer();
  static CameraPosition _currentLocationCamera = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 17.4746,
  );

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

    setState(() {
      latitude = lat;
      longitude = lng;
      // _markers.remove(_markers.elementAt(0));
      _markers.add(
        Marker(
          markerId: MarkerId("User"),
          position: LatLng(lat, lng),
        ),
      );
    });

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
    _markers.add(
      Marker(
        markerId: MarkerId("User"),
        position: LatLng(latitude, longitude),
      ),
    );
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 55.0,
            vertical: 15,
          ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),
            onTabChange: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/home');
              } else if (index == 1) {
                Navigator.pushNamed(context, '/helper');
              } else if (index == 2) {
                Navigator.pushNamed(context, '/history');
              }
            },
            gap: 4,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.touch_app,
                text: 'Helper',
              ),
              GButton(
                icon: Icons.article,
                text: 'History',
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // flutterflow
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 105,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-0.8, -1),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 30, 160, 10),
                            child: Text(
                              'Halo, User',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Verdana',
                                  color: Color.fromARGB(255, 153, 127, 27)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Text(
                            'Direct people to make their days better',
                            style: TextStyle(
                              fontFamily: 'Verdana',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            // FlutterFlowTheme.of(context).bodyMedium.override(
                            //       fontFamily: 'Readex Pro',
                            //       fontWeight: FontWeight.w500,
                            //     ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 340,
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 30, 0),
                      child: Text(
                        'Let\'s help the people around us',
                        style: TextStyle(
                          fontFamily: "Verdana",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Container(
                      width: 300,
                      height: 320,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _currentLocationCamera,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        markers: _markers,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 60, 210, 0),
              child: Text('Recent Hailor',
                  style: TextStyle(
                    fontFamily: 'Verdana',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  )),
            ),
            const Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 170, 20),
                child: Text(
                  'You can help them again',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              width: 347,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 7),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/Rectangle_31.png',
                      width: 116,
                      height: 200,
                      fit: BoxFit.contain,
                      alignment: const Alignment(0, 0),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 12),
                        child: Text(
                          'Andi loq',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        ' ???',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Column(
      //   children: [
      //     const SizedBox(
      //       height: 300,
      //     ),
      //     const Text(
      //       'Home Screen',
      //       style: TextStyle(
      //         fontSize: 30,
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     Center(
      //       child: ref.watch(getAuthenticatedUserProvider).when(
      //             loading: () => const CircularProgressIndicator(),
      //             data: (email) => Text(email),
      //             error: (error, stackTrace) {
      //               debugPrint(error.toString());
      //               return const Text('User information is not available!');
      //             },
      //           ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final isCleared = await ref.read(resetStorage);
      //     if (isCleared) {
      //       // ignore: use_build_context_synchronously
      //       Navigator.popAndPushNamed(context, 'Login');
      //     }
      //   },
      //   child: const Icon(Icons.delete),
      // ),
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
