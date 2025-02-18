import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hahoon/appTheme.dart';
import 'package:hahoon/modules/profile/profileScreen.dart';
import 'package:hahoon/modules/test/testScreen.dart';

enum BottomBarType { Test, Profile }

class BottomTabScreen extends StatefulWidget {
  static const String path = '/bottomTabScreen';
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  bool isFirstTime = true;
  Widget indexView = Container();
  BottomBarType bottomBarType = BottomBarType.Test;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: AppTheme.getTheme().backgroundColor,
        bottomNavigationBar: Container(
            height: 54 + MediaQuery.of(context).padding.bottom,
            child: getBottomBarUI(bottomBarType)),
        body: isFirstTime
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : indexView,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getTheme().dividerColor,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // Expanded(
                //   child: Material(
                //     color: Colors.transparent,
                //     child: InkWell(
                //       highlightColor: Colors.transparent,
                //       splashColor:
                //           AppTheme.getTheme().primaryColor.withOpacity(0.2),
                //       onTap: () {
                //         tabClick(BottomBarType.Test);
                //       },
                //       child: Column(
                //         children: <Widget>[
                //           SizedBox(
                //             height: 4,
                //           ),
                //           Container(
                //             width: 40,
                //             height: 32,
                //             child: Icon(
                //               Icons.search,
                //               size: 26,
                //               color: tabType == BottomBarType.Test
                //                   ? AppTheme.getTheme().primaryColor
                //                   : AppTheme.getTheme().disabledColor,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(bottom: 6),
                //             child: Text(
                //               "Test",
                //               style: TextStyle(
                //                   fontWeight: FontWeight.w500,
                //                   color: tabType == BottomBarType.Test
                //                       ? AppTheme.getTheme().primaryColor
                //                       : AppTheme.getTheme().disabledColor),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(BottomBarType.Test);
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: 40,
                            height: 32,
                            child: Icon(
                              FontAwesomeIcons.heart,
                              color: tabType == BottomBarType.Test
                                  ? AppTheme.getTheme().primaryColor
                                  : AppTheme.getTheme().disabledColor,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Test",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: tabType == BottomBarType.Test
                                      ? AppTheme.getTheme().primaryColor
                                      : AppTheme.getTheme().disabledColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(BottomBarType.Profile);
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: 40,
                            height: 32,
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: tabType == BottomBarType.Profile
                                  ? AppTheme.getTheme().primaryColor
                                  : AppTheme.getTheme().disabledColor,
                              size: 22,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: tabType == BottomBarType.Profile
                                      ? AppTheme.getTheme().primaryColor
                                      : AppTheme.getTheme().disabledColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = Container();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _startLoadScreen());
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _controller!.reverse().then((f) {
        if (tabType == BottomBarType.Test) {
          setState(() {
            indexView = TestScreen();
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            indexView = ProfileScreen();
          });
        }
      });
    }
  }

  Future<void> _startLoadScreen() async {
    if (mounted)
      setState(() {
        isFirstTime = false;
        indexView = TestScreen();
      });
    try {
      await _controller!.forward();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      print('animation got canceled');
    }
  }
}
