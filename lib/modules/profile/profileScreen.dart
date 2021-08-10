import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hahoon/stores/authStore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final appText = AppLocalizations.of(context)!;
    final authStore = Provider.of<AuthStore>(context, listen: false);

    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            children: [
              Text(appText.helloWorld, style: TextStyle(fontSize: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('lang', 'en');
                        authStore.setLang('en');
                      },
                      child: Text('En')),
                  TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('lang', 'th');
                        authStore.setLang('th');
                      },
                      child: Text('Th'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
