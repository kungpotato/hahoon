import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final appText = AppLocalizations.of(context)!;
    final local = MaterialLocalizations.of(context);

    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Text(appText.helloWorld, style: TextStyle(fontSize: 30)),
            Text(local.okButtonLabel, style: TextStyle(fontSize: 30)),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.camera,
                      size: 40,
                    ),
                    label: Text(
                      'Camera',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
