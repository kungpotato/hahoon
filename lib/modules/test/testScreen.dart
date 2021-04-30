import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
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
      ),
    );
  }
}
