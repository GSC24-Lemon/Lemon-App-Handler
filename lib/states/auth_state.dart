import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler/states/storage_state.dart';

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
        accessTokenExpiredAt = json['access_token_expires_at'],
        refreshTokenExpiredAt = json['refresh_token_expires_at'];
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
    final response = await http.post(
      Uri.http('192.168.4.122:8080', '/v1/auth/login'),
      body: {
        'email': args.email,
        'password': args.password,
      },
    );
    authValues = AuthValues.fromJson(jsonDecode(response.body));
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
    return Future.delayed(const Duration(seconds: 2), () async {
      final authResponse = await ref.watch(authenticationHandlerProvider).login(
            authArgs,
          );
      final isAuthenticated = authResponse.statusCode == 200;
      if (isAuthenticated) {
        ref.read(setAuthStateProvider.notifier).state = authResponse;
        ref.read(setIsAuthenticatedProvider(isAuthenticated));
        ref.read(setAuthenticatedUserProvider(authResponse.authValues.email));
      } else {
        ref.read(authErrorMessageProvider.notifier).state =
            'Error occurred while login with code: ${authResponse.statusCode}';
      }

      return isAuthenticated;
    });
  },
);

final authErrorMessageProvider = StateProvider<String>(
  (ref) => '',
);
