import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hahoon/main.dart';
import 'package:hahoon/modules/helpers/WidgetHelper.dart';
import 'package:hahoon/modules/login/forgotPasswordScreen.dart';
import 'package:hahoon/stores/authStore.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../appTheme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSubmit = false;

  final emailController = TextEditingController(text: 'kung@mail.com');
  final passwordController = TextEditingController(text: '1234');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isSave = false;

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            "เข้าสู่ระบบ",
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: AppTheme.getTheme().backgroundColor,
        body: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: appBar(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                  child: getFTButton(onTap: () {}),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: getFTButton(
                                      isFacebook: false, onTap: () {}),
                                ),
                                SizedBox(
                                  width: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "หรือเข้าสู่ระบบด้วยอีเมล",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.getTheme().disabledColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getTheme().backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(38)),
                              // border: Border.all(
                              //   color: HexColor("#757575").withOpacity(0.6),
                              // ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.getTheme().dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                height: 48,
                                child: Center(
                                  child: TextFormField(
                                    validator: (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'กรุณาใส่อีเมล';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                    maxLines: 1,
                                    onChanged: (String txt) {},
                                    style: TextStyle(
                                      fontSize: 16,
                                      // color: AppTheme.dark_grey,
                                    ),
                                    cursorColor:
                                        AppTheme.getTheme().primaryColor,
                                    decoration: new InputDecoration(
                                      errorText: null,
                                      border: InputBorder.none,
                                      hintText: "อีเมล",
                                      hintStyle: TextStyle(
                                          color: AppTheme.getTheme()
                                              .disabledColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getTheme().backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(38)),
                              // border: Border.all(
                              //   color: HexColor("#757575").withOpacity(0.6),
                              // ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.getTheme().dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                height: 48,
                                child: Center(
                                  child: TextFormField(
                                    obscureText: true,
                                    validator: (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'กรุณาใส่รหัสผ่าน';
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    maxLines: 1,
                                    onChanged: (String txt) {},
                                    style: TextStyle(
                                      fontSize: 16,
                                      // color: AppTheme.dark_grey,
                                    ),
                                    cursorColor:
                                        AppTheme.getTheme().primaryColor,
                                    decoration: new InputDecoration(
                                      errorText: null,
                                      border: InputBorder.none,
                                      hintText: "รหัสผ่าน",
                                      hintStyle: TextStyle(
                                          color: AppTheme.getTheme()
                                              .disabledColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: 16, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ลืมหรัสผ่าน",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.getTheme().disabledColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 8, top: 8),
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
                                  // Navigator.pushAndRemoveUntil(context, Routes.SPLASH, (Route<dynamic> route) => false);

                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context,
                                  //     Routes.TabScreen,
                                  //     (Route<dynamic> route) => false);

                                  // Navigator.pushReplacementNamed(context, Routes.TabScreen);
                                  if (_formKey.currentState.validate()) {
                                    _submitForm();
                                  }
                                },
                                child: isSave
                                    ? loader()
                                    : Center(
                                        child: Text(
                                          "เข้าสู่ระบบ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (mounted) setState(() => isSave = true);
    if (mounted) setState(() => isSubmit = true);
    final authStore = Provider.of<AuthStore>(context, listen: false);
    authStore
        .signInWithCloud(
            emailController.value.text, passwordController.value.text)
        .flatMap((fbUser) {
      authStore.setFbUser(fbUser.user);
      return authStore.getDbUser(fbUser.user.uid);
    }).listen((res) {
      if (res != null) {
        authStore.setDbUser(res);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.TabScreen, (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ไม่พบผู้ใช้')));
      }
    }, onError: (e) {
      if (mounted) setState(() => isSubmit = false);
      String errMsg = e.toString();
      print('err=>$e');
      if (e is PlatformException) {
        final PlatformException err = e;
        errMsg = err.details['message'] == 'INTERNAL'
            ? 'Please, check internet connetion'
            : err.details['message'];
      } else if (e is Map) {
        print('err=>${e['code']}');
        if (e['code'] == 500) errMsg = 'Wrong username or password';
      } else {
        print('err=>$e');
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errMsg)));
      print(errMsg);
    }, onDone: () {
      if (mounted) setState(() => isSave = false);
    });
  }
}
