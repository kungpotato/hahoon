import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hahoon/appTheme.dart';

Widget getFTButton({bool isFacebook: true, required Function onTap}) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: HexColor(isFacebook ? "#3C5799" : "#b2e5eb"),
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
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
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        highlightColor: Colors.transparent,
        onTap: onTap as void Function()?,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                  isFacebook
                      ? FontAwesomeIcons.facebookF
                      : FontAwesomeIcons.google,
                  size: 20,
                  color: isFacebook ? Colors.white : Colors.black54),
              SizedBox(
                width: 4,
              ),
              Text(
                isFacebook ? "Facebook" : "Google",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: isFacebook ? Colors.white : Colors.black54),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget loader() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
    ),
  );
}
