import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lemon_app_handler_new/widgets/button_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends ConsumerState<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController telephoneNumber = TextEditingController();

  // focus node
  FocusNode usernameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode telephoneFocus = FocusNode();
  FocusNode submitButtonFocus = FocusNode();
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();

    _recognizer = TapGestureRecognizer()..onTap = () {
        Navigator.pushNamed(context, '/login');
    };
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    telephoneNumber.dispose();
    usernameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    telephoneFocus.dispose();
    submitButtonFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    'R E G I S T E R',
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
                    'Register to Assist with Providing Directions',
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      color: Colors.black,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 15),
                    child: Container(
                      width: 354,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F7F9),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: username,
                          focusNode: usernameFocus,
                          autofocus: true,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'Username',
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
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Username!";
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFocus);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                child: Container(
                  width: 354,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7F9),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: email,
                      focusNode: emailFocus,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Verdana',
                        color: Color(0xFF8391A1),
                      ),
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
                    color: const Color(0xFFF4F7F9),
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
                      controller: password,
                      focusNode: passwordFocus,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Verdana',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF8391A1),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Verdana',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF8391A1),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Verdana',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF8391A1),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password!";
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
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
                      controller: telephoneNumber,
                      focusNode: telephoneFocus,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Telephone Number',
                        labelStyle: TextStyle(
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Verdana',
                          color: Color(0xFF8391A1),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Verdana',
                        color: Color(0xFF8391A1),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Telephone Number";
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
              child: ButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'REGISTER',
                options: FFButtonOptions(
                  width: 331,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Color(0xFFFAD02C),
                  textStyle: const TextStyle(
                    fontFamily: 'Verdana',
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 10,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  hoverColor: const Color(0xFFF5D14E),
                  hoverBorderSide: const BorderSide(
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
                    const Text('Already have an account?',
                        style: TextStyle(
                          fontFamily: 'Verdana',
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 14,
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: RichText(
                        text:  TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login Now',
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

                      //    Text(
                      //   'Login Now',
                      //   style: TextStyle(
                      //     fontFamily: 'Verdana',
                      //     color: Color(0xFFA2BBCF),
                      //     fontSize: 14,
                      //   ),

                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
