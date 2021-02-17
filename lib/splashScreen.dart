import 'package:flutter/material.dart';
import 'package:hahoon/introductionScreen.dart';
import 'package:hahoon/main.dart';
import 'package:hahoon/modules/helpers/WidgetHelper.dart';
import 'package:hahoon/stores/authStore.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'appTheme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoad = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: isLoad
            ? loader()
            : Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.white,
                          Colors.cyan[100],
                        ])),
                    foregroundDecoration: !AppTheme.isLightTheme
                        ? BoxDecoration(
                            color: AppTheme.getTheme()
                                .backgroundColor
                                .withOpacity(0.4))
                        : null,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    // child: Image.asset('assets/images/introduction.jpg',
                    //     fit: BoxFit.cover),
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Center(
                        child: Container(
                          width: 2000,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       color: AppTheme.getTheme().dividerColor,
                            //       offset: Offset(1.1, 1.1),
                            //       blurRadius: 10.0),
                            // ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            child: Image.asset(
                              'assets/images/appIcon.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "หามูลค่าหุ้นด้วยตัวเอง",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          shadows: <Shadow>[
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(1.5, 1.5),
                                blurRadius: 10.0),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "การคิดลดกระแสเงินสด \n ( Discounted Cash Flow )",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          shadows: <Shadow>[
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(1.5, 1.5),
                                blurRadius: 10.0),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 48, right: 48, bottom: 8, top: 8),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.getTheme().primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppTheme.getTheme().dividerColor,
                                blurRadius: 8,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                              highlightColor: Colors.transparent,
                              onTap: () {
                                // final authStore =
                                //     Provider.of<AuthStore>(context, listen: false);
                                // authStore.testCall();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          IntroductionScreen()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "เริ่มต้นใช้งาน",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                24.0 + MediaQuery.of(context).padding.bottom,
                            top: 16),
                        child: Text(
                          "หรือลงชื่อเข้าใช้งาน ด้วยบัญชีที่มีอยู่แล้ว",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            shadows: <Shadow>[
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(1, 1),
                                  blurRadius: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void initState() {
    final authStore = Provider.of<AuthStore>(context, listen: false);

    authStore.onAuthStateChangedFirebase().flatMap((fbUser) {
      authStore.setFbUser(fbUser);
      return authStore.getDbUser(fbUser.uid);
    }).listen((user) {
      if (user != null) {
        authStore.setDbUser(user);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.TabScreen, (Route<dynamic> route) => false);
      }
    }, onError: (err) {
      print(err);
    }, onDone: () {
      if (mounted) setState(() => isLoad = false);
    });
    super.initState();
  }
}
