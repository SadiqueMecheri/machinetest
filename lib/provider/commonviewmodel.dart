import 'package:flutter/material.dart';
import '../model/get_chatprofile_model.dart';
import '../model/getsinglechat_model.dart';
import '../model/login_model.dart';
import '../model/otp_response.dart';
import '../webservice/webservice.dart';

class CommonViewModel extends ChangeNotifier {
  //Get OTP
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
      return {
        'status': false,
        'message': 'An error occurred',
        'responsedata': {}
      };
    } finally {
      registrationloading = false;
      notifyListeners();
    }
  }

  // Confirm OTP
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
        responsedatafromotp = confirmotp!['responsedata'];
      }
      otpconfirmloading = false;
      notifyListeners();
      return confirmotp!;
    } catch (e) {
      confirmotp = null;
      return {
        'status': false,
        'message': 'An error occurred',
        'responsedata': {}
      };
    } finally {
      otpconfirmloading = false;
      notifyListeners();
    }
  }

  //fetch all chats
  late Map<String, dynamic> allchat;
  bool fetchallchatsloading = false;
  late List<ChatMainList> allchatlist;

  Future<Map<String, dynamic>> fetchallchats() async {
    fetchallchatsloading = true;
    allchat = await Webservice().fetchallchats();
    allchatlist = allchat['allchatdata'];
    filteredChatList = List.from(allchatlist); // Initialize filtered list
    fetchallchatsloading = false;
    notifyListeners();
    return allchat;
  }

  //for chat search
  List<ChatMainList> filteredChatList = [];
  String searchQuery = '';

  void filterChats(String query) {
    searchQuery = query.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredChatList = List.from(allchatlist);
    } else {
      filteredChatList = allchatlist.where((chat) {
        return chat.attributes!.name!.toLowerCase().contains(searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  //fetchsinglechat
  late Map<String, dynamic> singchat;
  bool fetchsinglechatloading = false;
  late List<SingleChat> singlechatlist;

  Future<Map<String, dynamic>> getsinglechat(String id, int userid) async {
    fetchsinglechatloading = true;
    singchat = await Webservice().getsinglechat(id, userid);
    singlechatlist = singchat['singlechat'];
    fetchsinglechatloading = false;
    notifyListeners();
    return singchat;
  }

  //to sent new messages
  void addNewMessage(SingleChat newMessage) {
    singlechatlist.add(newMessage);
    notifyListeners();
  }
}
