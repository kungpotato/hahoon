import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hahoon/appTheme.dart';
import 'package:hahoon/modules/bottomTab/bottomTabScreen.dart';
import 'package:hahoon/splashScreen.dart';
import 'package:hahoon/stores/authStore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  print('Initialized default app $app');
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
  }
  if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
    // Collection is enabled.
  }
  print(
      'CrashlyticsCollectionEnabled==>${FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled}');
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runZonedGuarded(() {
            runApp(Root());
          }, (error, stackTrace) {
            print('runZonedGuarded: Caught error in my root zone.');
            FirebaseCrashlytics.instance.recordError(error, stackTrace);
          }));
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static restartApp(BuildContext context) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();

    state.restartApp();
  }

  static setCustomTheme(BuildContext context) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setCustomTheme();
  }
}

class Routes {
  static const String SPLASH = "/";
  static const String TabScreen = BottomTabScreen.path;
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.TabScreen: (BuildContext context) => BottomTabScreen(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          AppTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return Container(
      key: key,
      color: AppTheme.getTheme().backgroundColor,
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Hahoon',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(),
          routes: routes,
          builder: (BuildContext context, Widget child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Builder(
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).size.width > 360
                          ? 1.0
                          : MediaQuery.of(context).size.width >= 340
                              ? 0.9
                              : 0.8,
                    ),
                    child: child,
                  );
                },
              ),
            );
          }),
    );
  }

  void restartApp() {
    this.setState(() {
      navigatorKey = GlobalKey<NavigatorState>();
      key = UniqueKey();
    });
  }

  void setCustomTheme() {
    setState(() {
      AppTheme.isLightTheme = !AppTheme.isLightTheme;
    });
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthStore>.value(value: AuthStore()),
        // Provider<UserStore>.value(value: UserStore()),
      ],
      child: MyApp(),
    );
  }
}
