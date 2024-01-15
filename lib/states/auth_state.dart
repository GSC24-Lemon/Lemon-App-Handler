import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler_new/states/storage_state.dart';

class AuthArgs {
  final String email;
  final String password;
  AuthArgs({required this.email, required this.password});
}

class AuthValues {
  AuthValues({
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.accessTokenExpiredAt,
    required this.refreshTokenExpiredAt,
  });
  final String token;
  final String refreshToken;
  final String email;
  final DateTime accessTokenExpiredAt;
  final DateTime refreshTokenExpiredAt;

  AuthValues.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        token = json['access_token'],
        refreshToken = json['refresh_token'],
        accessTokenExpiredAt = DateTime.parse(json['access_token_expires_at']),
        refreshTokenExpiredAt =
            DateTime.parse(json['refresh_token_expires_at']);
}

class AuthResponse {
  AuthResponse({required this.authValues, required this.statusCode});
  final AuthValues authValues;
  final int statusCode;
}

class AuthenticationHandler {
  late AuthValues authValues = AuthValues(
    email: '',
    refreshToken: '',
    token: '',
    accessTokenExpiredAt: DateTime.now(),
    refreshTokenExpiredAt: DateTime.now(),
  );

  Future<AuthResponse> login(AuthArgs args) async {
    debugPrint("email: " + args.email + " password: " + args.password);
    final response =
        await http.post(Uri.http('192.168.139.122:8080', '/v1/auth/login'),
            body: jsonEncode({
              'email': args.email,
              'password': args.password,
            }),
            headers: {"Content-Type": "application/json"});
    authValues = AuthValues.fromJson(jsonDecode(response.body));
    debugPrint(authValues.toString());
    // return response.statusCode;
    return AuthResponse(
      authValues: authValues,
      statusCode: response.statusCode,
    );
  }
}

final authenticationHandlerProvider = StateProvider<AuthenticationHandler>(
  (_) => AuthenticationHandler(),
);

final authLoginProvider = FutureProvider.family<bool, AuthArgs>(
  (ref, authArgs) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final authResponse = await ref.watch(authenticationHandlerProvider).login(
            authArgs,
          );
      final isAuthenticated =
          authResponse.statusCode == 200 || authResponse.statusCode == 201;
      if (isAuthenticated) {
        ref.read(setAuthStateProvider.notifier).state = authResponse;
        ref.read(setIsAuthenticatedProvider(isAuthenticated));
        ref.read(setAuthenticatedUserProvider(authResponse.authValues.email));
      } else {
        ref.read(authErrorMessageProvider.notifier).state =
            'Error occurred while login with code: ${authResponse.statusCode}';
            return false;
      }

      return isAuthenticated;
    });
  },
);

final authErrorMessageProvider = StateProvider<String>(
  (ref) => '',
);
