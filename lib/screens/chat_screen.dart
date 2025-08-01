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
  int? _tempMessageId = 0;
  final ScrollController _scrollController = ScrollController();

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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
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
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  widget.coursedata.attributes!.profilePhotoUrl.toString()),
            ),
            Space.w10,
            Column(
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
          ],
        ),
      ),
      body: Consumer<CommonViewModel>(builder: (context, data, child) {
        if (data.fetchsinglechatloading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final groupedMessages = _groupMessagesByDate(data.singlechatlist);
          final sortedDates = groupedMessages.keys.toList()
            ..sort((a, b) {
              if (a == 'Today') return 1;
              if (b == 'Today') return -1;
              if (a == 'Yesterday' && b != 'Today') return 1;
              if (b == 'Yesterday' && a != 'Today') return -1;
              return b.compareTo(a);
            });

          return Column(
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
                        offset: const Offset(0, -4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: data.singlechatlist.isEmpty
                      ? const Center(
                          child: Text(
                          "No Chats Available",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ))
                      : SingleChildScrollView(
                          controller: _scrollController,
                          reverse: true,
                          child: Column(
                            children: [
                              Space.h20,
                              ...sortedDates.expand((date) {
                                final messages = groupedMessages[date]!;
                                return [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color:
                                          Appcolor().secondarybackgroundColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 2, bottom: 2),
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Space.h10,
                                  ...messages.map((coursedata) {
                                    final isCurrentUser = coursedata
                                            .attributes!.senderId
                                            .toString() ==
                                        currentuserid;
                                    return ChatBubble(
                                      text: coursedata.attributes!.message
                                          .toString(),
                                      isCurrentUser: isCurrentUser,
                                      time: coursedata.attributes!.createdAt!,
                                      deliverdat: coursedata
                                          .attributes!.deliveredAt
                                          .toString(),
                                    );
                                  }),
                                  Space.h10,
                                ];
                              }).toList(),
                              SizedBox(height: 100),
                              SizedBox(height: 100),
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
                    onTap: () => _sendMessage(),
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

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = SingleChat(
      type: "chat_message",
      id: (_tempMessageId!).toString(),
      attributes: datarum.DatumAttributes(
        chatThreadId: 1,
        senderId: int.tryParse(currentuserid ?? '0'),
        receiverId: 1,
        message: _messageController.text,
        chatMessageTypeId: 1,
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
          data: gift.Data(
            id: currentuserid,
            type: "user",
          ),
        ),
      ),
    );

    vm!.addNewMessage(newMessage);
    _messageController.clear();
    _tempMessageId = _tempMessageId! - 1;

    // Scroll to bottom after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Map<String, List<SingleChat>> _groupMessagesByDate(
      List<SingleChat> messages) {
    final grouped = <String, List<SingleChat>>{};

    for (final message in messages) {
      final date = message.attributes!.createdAt!;
      final dateKey = _getDateKey(date);

      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(message);
    }

    return grouped;
  }

  String _getDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (today.difference(messageDate).inDays == 0) {
      return 'Today';
    } else if (today.difference(messageDate).inDays == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }
}
