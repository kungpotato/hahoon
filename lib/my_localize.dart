import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyLocalizations {
  MyLocalizations(this.localeName);

  static MyLocalizations load(Locale locale) {
    final String name =
        locale.countryCode == null || locale.countryCode!.isEmpty
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return MyLocalizations(localeName);
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
