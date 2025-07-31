
import 'package:flutter/material.dart';

import '../contants.dart';

// ignore: must_be_immutable
class widgetStartContainer extends StatelessWidget {
  String title;
  String icon;
  Color titlecolor;
  Color color;
  final VoidCallback? onTap;
  widgetStartContainer({
    super.key,
    required this.icon,
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
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 18, width: 18),
            Space.w5,
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: titlecolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
