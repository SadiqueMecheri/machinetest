import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../contants.dart';
import '../provider/commonviewmodel.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CommonViewModel? vm;

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.fetchallchats();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
      backgroundColor: Appcolor().backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor().backgroundColor,
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
        title: Text(
          "Messages",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CommonViewModel>(builder: (context, courses, child) {
        if (courses.fetchallchatsloading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return courses.allchatlist.length == 0
              ? const Center(
                  child: Text(
                  "No Chats Available",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  courses.allchatlist.length, (index) {
                                final coursedata = courses.allchatlist[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    width: 55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                              coursedata
                                                  .attributes!.profilePhotoUrl
                                                  .toString()),
                                        ),
                                        Space.h5,
                                        Text(
                                          coursedata.attributes!.name
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            height: 1,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      Space.h5,
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: 15.0 /
                                    MediaQuery.textScaleFactorOf(context),
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Search ",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                errorStyle: TextStyle(
                                  fontSize: 15.0 /
                                      MediaQuery.textScaleFactorOf(context),
                                  color: Colors.red.shade900,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/search.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 15,
                                  bottom: 15,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                            Space.h15,
                            Text(
                              "Chat",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Space.h20,
                            Column(
                              children: List.generate(1, (index) {
                                return ListTile(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return ChatScreen();
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  contentPadding: EdgeInsets.all(0),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                      "assets/images/profile.png",
                                    ),
                                  ),
                                  title: Text(
                                    "Regina Bearden",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Space.h10,
                            Divider(color: Colors.grey.shade300),
                            Space.h10,
                            Column(
                              children: List.generate(
                                  courses.allchatlist.length, (index) {
                                final coursedata = courses.allchatlist[index];
                                DateTime utcTime = DateTime.parse(coursedata
                                    .attributes!.lastActiveAt
                                    .toString());

// Convert to local time (optional, depending on your use case)
                                DateTime localTime = utcTime.toLocal();

// Format to AM/PM
                                String formattedTime =
                                    DateFormat('hh:mm a').format(localTime);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ChatScreen(
                                                coursedata: coursedata);
                                          },
                                        ),
                                      );
                                    },
                                    contentPadding: EdgeInsets.all(0),
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(coursedata
                                          .attributes!.profilePhotoUrl
                                          .toString()),
                                    ),
                                    title: Text(
                                      coursedata.attributes!.name.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: Text(
                                      formattedTime,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        }
      }),
    );
  }
}
