import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../contants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.text,
      required this.time,
      required this.deliverdat,
      required this.isCurrentUser})
      : super(key: key);
  final String text, deliverdat;
  final DateTime time;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    log("deliveruuu---" + deliverdat);
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isCurrentUser ? Appcolor().primaryColor : Colors.grey[200],
                  borderRadius: isCurrentUser
                      ? BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: isCurrentUser ? Colors.white : Colors.black87,
                          fontSize: 13,
                        ),
                  ),
                ),
              ),
            ),
            Space.h5,
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!isCurrentUser) ...[
                  deliverdat == "null"
                      ? Icon(Icons.done, size: 18.0, color: Colors.grey)
                      : Image.asset(
                          "assets/images/double-tick.png",
                          height: 15,
                        ),
                  Space.w5,
                ],
                Text(
                  DateFormat('hh:mm a')
                      .format(DateTime.parse(time.toString()).toLocal()),
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                if (isCurrentUser) ...[
                  Space.w5,
                  deliverdat == "null"
                      ? Icon(Icons.done, size: 18.0, color: Colors.grey)
                      : Image.asset("assets/images/double-tick.png", height: 15),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}