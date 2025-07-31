import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machinetest/model/get_chatprofile_model.dart';
import 'package:provider/provider.dart';

import '../contants.dart';
import '../model/getsinglechat_model.dart';
import '../model/getsinglechat_model.dart' as datarum;
import '../model/getsinglechat_model.dart' as relation;
import '../model/getsinglechat_model.dart' as gift;
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final ChatMainList coursedata;

  ChatScreen({
    super.key,
    required this.coursedata,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CommonViewModel? vm;
  String? currentuserid;
   final TextEditingController _messageController = TextEditingController();
     int? _tempMessageId = 0; // For generating temporary IDs

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.getsinglechat(widget.coursedata.id.toString(),
        widget.coursedata.attributes!.authUserId!);
    loaduser();
    super.initState();
  }

  loaduser() async {
    currentuserid = await Store.getname();
    setState(() {});
  }


void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    // Create a new message object
    final newMessage = SingleChat(
      type: "chat_message",
      id: (_tempMessageId!).toString(), // Temporary negative ID
      attributes:datarum.DatumAttributes(
        chatThreadId: 100,
        senderId: int.tryParse(currentuserid ?? '0'),
        receiverId:100,
        message: _messageController.text,
        chatMessageTypeId: 1, // Assuming 1 is for text messages
        sentAt: DateTime.now(),
        deliveredAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isReadReceiptsOn: 1,
        isOneTimeView: false,
        isOnVanishMode: false,
      ),
      relationships: relation.Relationships(
        sender: GiftOrder(
          data:gift. Data(
            id: currentuserid,
            type: "user",
          ),
        ),
      ),
    );

    // Add to local list
    vm!.addNewMessage(newMessage);

    // Clear the input field
    _messageController.clear();

    // Here you would call your API to send the message
    // vm!.sendMessageToServer(
    //   threadId: widget.coursedata.id.toString(),
    //   message: _messageController.text,
    //   tempMessage: newMessage, // Pass the temp message to update ID later
    // );
  }
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor().secondarybackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        surfaceTintColor: Appcolor().secondarybackgroundColor,
        backgroundColor: Appcolor().secondarybackgroundColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/back-button.png',
            height: 80,
            width: 80,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.coursedata.attributes!.name.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 3),
            Row(
              children: [
                (widget.coursedata.attributes!.isOnline!)
                    ? Text(
                        "online",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        DateFormat('hh:mm a').format(DateTime.parse(widget
                                .coursedata.attributes!.lastActiveAt
                                .toString())
                            .toLocal()),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                SizedBox(width: 4),
                (widget.coursedata.attributes!.isOnline!)
                    ? CircleAvatar(backgroundColor: Colors.green, radius: 6)
                    : SizedBox()
              ],
            ),
          ],
        ),
      ),
      body: Consumer<CommonViewModel>(builder: (context, courses, child) {
        if (courses.fetchsinglechatloading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return courses.singlechatlist.length == 0
              ? const Center(
                  child: Text(
                  "No Chats Available",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ))
              : Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              offset:
                                  const Offset(0, -4), // ⬅️ Shadow goes upward
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Space.h20,
                              Space.h10,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Appcolor().secondarybackgroundColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Text(
                                   formatMessageDate("2025-07-18T04:00:13.000000Z"),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ),
                              ),
                              Space.h20,
                              Column(
                                children: List.generate(
                                    courses.singlechatlist.length, (index) {
                                  final coursedata =
                                      courses.singlechatlist[index];

                                  final isCurrentUser =
                                      coursedata.attributes!.senderId.toString() == currentuserid;


                                      log("atriuteid----"+ coursedata.attributes!.senderId.toString());
                                             log("currrntnt----"+ currentuserid.toString());
                                      log("dadadada----"+isCurrentUser.toString());

                                  return ChatBubble(
                                    text: coursedata.attributes!.message
                                        .toString(),
                                    isCurrentUser: isCurrentUser,
                                    time: coursedata.attributes!.createdAt!, deliverdat:  coursedata.attributes!.deliveredAt.toString(),
                                  );
                                }),

                                
                              ),
                              SizedBox(height: 200),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }
      }),
      bottomSheet: Container(
        height: 100,
        color: Colors.white,
        child: Column(
          children: [
            Divider(),
            Space.h10,
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                autofocus: false,
                 controller: _messageController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 15.0 / MediaQuery.textScaleFactorOf(context),
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  hintText: "Type Something ",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  errorStyle: TextStyle(
                    fontSize: 15.0 / MediaQuery.textScaleFactorOf(context),
                    color: Colors.red.shade900,
                  ),
                  suffixIcon: InkWell(
                    onTap: () =>    _sendMessage(),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/send.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                    bottom: 15,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    String formatMessageDate(String utcDateTimeString) {
    final DateTime utcDateTime = DateTime.parse(utcDateTimeString);
    final DateTime localDateTime = utcDateTime.toLocal();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate =
        DateTime(localDateTime.year, localDateTime.month, localDateTime.day);

    final difference = today.difference(messageDate).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return DateFormat.E().format(localDateTime); // e.g., Mon, Tue
    } else {
      return DateFormat('dd MMM yyyy')
          .format(localDateTime); // e.g., 18 Jul 2025
    }
  }
}
