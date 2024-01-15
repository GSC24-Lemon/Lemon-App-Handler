import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends ConsumerState<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 105,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Align(
                  alignment: AlignmentDirectional(-0.8, -1),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 20, 200, 10),
                          child: Text(
                            'History',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Verdana',
                              color: Color(0xFF997F1B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                          child: Text('Here is a list of people I have helped',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Verdana',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 25,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 350,
                    height: 133,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(5, 10),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 390,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Color(0xFF8FADC5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'Adinda',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    fontSize: 14,
                                    letterSpacing: 0.15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      140, 0, 0, 0),
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    color: Color.fromARGB(255, 87, 99, 108),
                                  ),
                                  // FaIcon(
                                  //   FontAwesomeIcons.clock,
                                  //   color: FlutterFlowTheme.of(context)
                                  //       .secondaryText,
                                  //   size: 20,
                                  // ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'A minutes ago',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.normal,
                                  ),

                                  // FlutterFlowTheme.of(context)
                                  //     .bodyMedium
                                  //     .override(
                                  //       fontFamily: 'Verdana',
                                  //       color: Color(0xFFFDFDFD),
                                  //       fontSize: 12,
                                  //       letterSpacing: 0.5,
                                  //       useGoogleFonts: false,
                                  //     ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 348,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'From:  ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      color: Colors.black,
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'To: ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),

                                    // FlutterFlowTheme.of(context)
                                    //     .bodyMedium
                                    //     .override(
                                    // fontFamily: 'Readex Pro',
                                    // fontSize: 13,
                                    // letterSpacing: 0.15,
                                    //     ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Material(
                  color: Colors.transparent,
                  elevation: 25,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 350,
                    height: 133,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(5, 10),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 390,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Color(0xFF8FADC5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'Adinda',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    fontSize: 14,
                                    letterSpacing: 0.15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      140, 0, 0, 0),
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    color: Color.fromARGB(255, 87, 99, 108),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'A minutes ago',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 348,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'From:  ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      color: Colors.black,
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'To: ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Material(
                  color: Colors.transparent,
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 350,
                    height: 133,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(5, 10),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 390,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Color(0xFF8FADC5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'Adinda',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    fontSize: 14,
                                    letterSpacing: 0.15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      140, 0, 0, 0),
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    color: Color.fromARGB(255, 87, 99, 108),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'A minutes ago',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 348,
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'From:  ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      color: Colors.black,
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'To: ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Material(
                  color: Colors.transparent,
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 350,
                    height: 133,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(5, 10),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 390,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Color(0xFF8FADC5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'Adinda',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    fontSize: 14,
                                    letterSpacing: 0.15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      140, 0, 0, 0),
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    color: Color.fromARGB(255, 87, 99, 108),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'A minutes ago',
                                  style: TextStyle(
                                    fontFamily: 'Verdana',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 348,
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'From:  ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      color: Colors.black,
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'To: ',
                                    style: TextStyle(
                                      fontFamily: 'Verdana',
                                      fontSize: 13,
                                      letterSpacing: 0.15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
