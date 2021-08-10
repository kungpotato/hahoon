import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyLocalizations {
  MyLocalizations(this.localeName);

  static Future<MyLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null || locale.countryCode!.isEmpty
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return SynchronousFuture<MyLocalizations>(MyLocalizations(localeName));
  }

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations)!;
  }

  final String localeName;

  String get helloWorld {
    return Intl.message(
      'Hello World',
      name: 'helloWorld',
      desc: 'Title for the Demo application',
      locale: localeName,
    );
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<MyLocalizations>(
        MyLocalizations(locale.languageCode));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
