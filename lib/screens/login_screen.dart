import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler_new/states/auth_state.dart';
import 'package:lemon_app_handler_new/states/storage_state.dart';

import '../widgets/button_widget.dart';

class LoginScreen extends HookConsumerWidget {
  LoginScreen({super.key});
  late TapGestureRecognizer _recognizer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final emailFocus = useFocusNode();
    final passwrodFocus = useFocusNode();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, '/register');
      };

    ref.listen(authErrorMessageProvider, (prev, String next) {
      if (next.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.toString()),
          ),
        );
      } else {
        emailController.text = '';
        passwordController.text = '';
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 230,
                      height: 197.68,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Text(
                    'L O G I N',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Verdana',
                      color: Colors.black,
                      letterSpacing: 0.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Login to Assist with Providing Directions',
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      color: Colors.black,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                    // FlutterFlowTheme.of(context).bodyMedium.override(
                    //       fontFamily: 'Verdana',
                    //       color: Colors.black,
                    //       fontSize: 14,
                    //       letterSpacing: 0.5,
                    //       useGoogleFonts: false,
                    //     ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 15),
                child: Container(
                  width: 354,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F7F9),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    border: Border.all(
                      width: 0.2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: emailController,
                      focusNode: emailFocus,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        labelStyle: TextStyle(
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                          fontWeight: FontWeight.normal,
                        ),
                        // FlutterFlowTheme.of(context).labelMedium.override(
                        //       fontFamily: 'Readex Pro',
                        //       color: Color(0xFF8391A1),
                        //     ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                          fontWeight: FontWeight.normal,
                        ),
                        //  FlutterFlowTheme.of(context).labelMedium,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Verdana',
                        color: Color(0xFF8391A1),
                        fontWeight: FontWeight.normal,
                      ),
                      // FlutterFlowTheme.of(context).bodyMedium,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email!";
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return "Enter Valid Email!";
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                child: Container(
                  width: 354,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F7F9),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    border: Border.all(
                      width: 0.2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                        controller: passwordController,
                        focusNode: passwrodFocus,
                        autofocus: true,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Verdana',
                            color: Color(0xFF8391A1),
                            fontWeight: FontWeight.normal,
                          ),

                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Verdana',
                            color: Color(0xFF8391A1),
                            fontWeight: FontWeight.normal,
                          ),
                          //  FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                          fontWeight: FontWeight.normal,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password!";
                          }
                        }),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: ButtonWidget(
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    final authArgs = AuthArgs(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    final isAuth = ref.read(authLoginProvider(authArgs));
                    final isAuthenticated =
                        ref.read(getIsAuthenticatedProvider);
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (isAuthenticated.value!) {
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                },
                text: 'LOGIN',
                options: FFButtonOptions(
                  width: 331,
                  height: 40,
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Color(0xFFFAD02C),
                  textStyle: const TextStyle(
                    fontFamily: 'Verdana',
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 10,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  hoverColor: Color(0xFFF5D14E),
                  hoverBorderSide: BorderSide(
                    color: Color(0xFFF5D14E),
                    width: 1,
                  ),
                  hoverElevation: 5,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(45, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Create a new account',
                                style: const TextStyle(
                                  fontFamily: 'Verdana',
                                  color: Color(0xFFA2BBCF),
                                  fontSize: 14,
                                ),
                                recognizer: _recognizer,
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   'Create a new account',
                        //   style:
                        //       FlutterFlowTheme.of(context).bodyMedium.override(
                        //             fontFamily: 'Readex Pro',
                        //             color: Color(0xFFA2BBCF),
                        //           ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child: Column(
      //     children: [
      //       const SizedBox(
      //         height: 200,
      //       ),
      //       TextField(
      //         controller: emailController,
      //         decoration: const InputDecoration(
      //           helperText: 'Email',
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       TextField(
      //         controller: passwordController,
      //         obscureText: true,
      //         decoration: const InputDecoration(
      //           helperText: 'Password',
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       TextButton(
      // onPressed: () async {
      //   if (emailController.text.isNotEmpty &&
      //       passwordController.text.isNotEmpty) {
      //     final authArgs = AuthArgs(
      //       email: emailController.text,
      //       password: passwordController.text,
      //     );
      //     ref.read(authLoginProvider(authArgs));
      //     final isAuthenticated = ref.read(getIsAuthenticatedProvider);
      //     if (isAuthenticated.value!) {
      //       Navigator.pushNamed(context, 'Home');
      //     }
      //   }
      // },
      //         child: const Text(
      //           'Login',
      //           style: TextStyle(fontSize: 18),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
