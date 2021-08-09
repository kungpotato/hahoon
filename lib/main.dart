import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hahoon/appTheme.dart';
import 'package:hahoon/modules/bottomTab/bottomTabScreen.dart';
import 'package:hahoon/splashScreen.dart';
import 'package:hahoon/stores/authStore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();

  print('Initialized default app $app');
  if (!kReleaseMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    // FirebaseCrashlytics.instance.crash();
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
    // Collection is enabled.

    // throw Exception("Error on test");
  }

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Routes {
  static const String SPLASH = "/";
  static const String TabScreen = BottomTabScreen.path;
}

class _MyAppState extends State<MyApp> {
  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.TabScreen: (BuildContext context) => BottomTabScreen(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppTheme.statusBarColors.withOpacity(0.5),
      // statusBarIconBrightness:
      //     AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      // statusBarBrightness:
      //     AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      // systemNavigationBarColor:
      //     AppTheme.isLightTheme ? Colors.white : Colors.black,
      // systemNavigationBarDividerColor: Colors.grey,
      // systemNavigationBarIconBrightness:
      //     AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return Container(
      color: AppTheme.getTheme().backgroundColor,
      child: MaterialApp(
          title: 'Hahoon',
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''), // English, no country code
            Locale('th', ''), // Spanish, no country code
          ],
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(),
          routes: routes,
          builder: (BuildContext context, Widget? child) {
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
                    child: child!,
                  );
                },
              ),
            );
          }),
    );
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
