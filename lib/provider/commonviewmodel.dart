import 'dart:developer';
import 'package:flutter/material.dart';

import '../model/get_chatprofile_model.dart';
import '../model/getsinglechat_model.dart';
import '../model/login_model.dart';
import '../model/otp_response.dart';
import '../webservice/webservice.dart';

class CommonViewModel extends ChangeNotifier {
  late Map<String, dynamic> reg;
  bool registrationloading = false;
  late LoginReposne responsedata;
  Future<Map<String, dynamic>> sendotp(String phonenumber) async {
    registrationloading = true;
    notifyListeners();
    try {
      reg = await Webservice().sendotp(phonenumber);
      responsedata = reg['responsedata'];
      registrationloading = false;
      notifyListeners();
      return reg;
    } catch (e) {
      // Handle any errors that occur during the API call
      return {
        'status': false,
        'message': 'An error occurred',
        'responsedata': {}
      };
    } finally {
      // This will run whether the call succeeds or fails
      registrationloading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic>? confirmotp;
  bool otpconfirmloading = false;
  OtpResponse? responsedatafromotp;
  Future<Map<String, dynamic>> confirmotpsent(
      String phonenumber, int otp) async {
    otpconfirmloading = true;
    notifyListeners();
    try {
      confirmotp = await Webservice().confirmotpsent(phonenumber, otp);
      if (confirmotp!['status'] == true &&
          confirmotp!['responsedata'] != null) {
        responsedatafromotp = confirmotp!['responsedata']; // ✅ only if valid
      }

      otpconfirmloading = false;
      notifyListeners();
      return confirmotp!;
    } catch (e) {
      // Handle any errors that occur during the API call
      confirmotp = null;
      return {
        'status': false,
        'message': 'An error occurred',
        'responsedata': {}
      };
    } finally {
      // This will run whether the call succeeds or fails
      otpconfirmloading = false;
      notifyListeners();
    }
  }

  // //fetchallcourse
  late Map<String, dynamic> allchat;
  bool fetchallchatsloading = false;

  late List<ChatMainList> allchatlist;
  int? android;
  int? apple;
  Future<Map<String, dynamic>> fetchallchats() async {
    fetchallchatsloading = true;

    allchat = await Webservice().fetchallchats();
    allchatlist = allchat['allchatdata'];
    log("allcourselist length ====== ${allchatlist.length}");
    fetchallchatsloading = false;
    notifyListeners();
    return allchat;
  }

  // //fetchsinglechat
  late Map<String, dynamic> singchat;
  bool fetchsinglechatloading = false;

  late List<SingleChat> singlechatlist;

  Future<Map<String, dynamic>> getsinglechat(String id, int userid) async {
    fetchsinglechatloading = true;

    singchat = await Webservice().getsinglechat(id, userid);
    singlechatlist = singchat['singlechat'];
    log("allcourselist length ====== ${singlechatlist.length}");
    fetchsinglechatloading = false;
    notifyListeners();
    return singchat;
  }


  void addNewMessage(SingleChat newMessage) {
  singlechatlist.insert(0, newMessage); // Add at beginning of list
  notifyListeners();
}
}
