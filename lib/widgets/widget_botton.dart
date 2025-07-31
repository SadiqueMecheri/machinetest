
import 'package:flutter/material.dart';

import '../contants.dart';

// ignore: must_be_immutable
class WidgetBotton extends StatelessWidget {
  String title;
  Color titlecolor;
  Color color;
  final VoidCallback? onTap;
  WidgetBotton({
    super.key,
    required this.title,
    required this.titlecolor,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: color,
          gradient: LinearGradient(
            colors: [Appcolor().buttonGradient2, Appcolor().primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: titlecolor,
            ),
          ),
        ),
      ),
    );
  }
}
