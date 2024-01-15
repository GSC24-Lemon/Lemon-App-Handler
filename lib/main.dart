import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lemon_app_handler_new/screens/help_screen.dart';
import 'package:lemon_app_handler_new/screens/helper_screen.dart';
import 'package:lemon_app_handler_new/screens/history_screen.dart';
import 'package:lemon_app_handler_new/screens/register_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler_new/states/storage_state.dart';
import 'package:lemon_app_handler_new/screens/login_screen.dart';
import 'package:lemon_app_handler_new/screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  // const MyApp({super.key});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ref
          .watch(
            getIsAuthenticatedProvider,
          )
          .when(
            data: (bool isAuthenticated) =>
                isAuthenticated ? HomeScreen() : const RegisterScreen(),
            loading: () {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (error, stacktrace) => LoginScreen(),
          ),
      routes: {
        "/home": (context) => const HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/help": (context) => HelpScreen(),
        "/register": (context) => const RegisterScreen(),
        "/helper": (context) => const HelperScreen(),
        "/history": (context) => const HistoryScreen(),
      },
    );
  }
}
