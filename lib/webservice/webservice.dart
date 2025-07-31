import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import '../model/get_chatprofile_model.dart';
import '../model/getsinglechat_model.dart';
import '../model/login_model.dart';
import '../model/otp_response.dart';
import '../session/shared_preferences.dart';

class Webservice {
  final String baseurl = "https://test.myfliqapp.com/api/v1/";

  Future<Map<String, dynamic>> sendotp(String phonenumber) async {
    var result3;

    Map<String, dynamic> data = {
      'data': {
        'type': 'registration_otp_codes',
        'attributes': {
          'phone': "+918087808780",
        },
      },
    };

    final response = await http.post(
      Uri.parse("${baseurl}auth/registration-otp-codes/actions/phone/send-otp"),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      LoginReposne authUser = LoginReposne.fromJson(responseData);

      result3 = {
        'status': true,
        'message': 'successful',
        'responsedata': authUser
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error'],
        'responsedata': {}
      };
    }
    return result3;
  }

  Future<Map<String, dynamic>> confirmotpsent(
      String phonenumber, int otp) async {
    var result3;
    Map<String, dynamic> data = {
      'data': {
        'type': 'registration_otp_codes',
        'attributes': {
          'phone': "++918087808780", // Example: '+918087808780'
          'otp': 111111, // Example: 111111
          'device_meta': {
            'type': 'web',
            'device-name': 'HP Pavilion 14-EP0068TU',
            'device-os-version': 'Linux x86_64',
            'browser': 'Mozilla Firefox Snap for Ubuntu (64-bit)',
            'browser_version': '112.0.2',
            'user-agent':
                'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0',
            'screen_resolution': '1600x900',
            'language': 'en-GB',
          }
        }
      }
    };

    final response = await http.post(
      Uri.parse(
          "${baseurl}auth/registration-otp-codes/actions/phone/verify-otp"),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Store.setUserid(
          decodedJson['data']['attributes']['auth_status']['access_token']);
                Store.setname(
          decodedJson['data']['id']);

      OtpResponse authUser = OtpResponse.fromJson(decodedJson);

      result3 = {
        'status': true,
        'message': 'successful',
        'responsedata': authUser
      };
    } else {
      result3 = {
        'status': false,
        'message': decodedJson['error']['message'],
        'responsedata': null // ✅ more accurate
      };
    }
    return result3;
  }

 Future<Map<String, dynamic>> fetchallchats() async {
  try {
    String? token = await Store.getUserid();
    final response = await http.get(
      Uri.parse("${baseurl}chat/chat-messages/queries/contact-users"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("HTTP Status Code: ${response.statusCode}");
    log("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      log("Decoded JSON: $decodedJson");

      // Log specific field for debugging
      log("Data exists: ${decodedJson['data'] != null}");
      if (decodedJson['data'] != null && decodedJson['data'].isNotEmpty) {
        log("First item attributes: ${decodedJson['data'][0]['attributes']}");
        log("Parsed JSON 0002: ${decodedJson['data'][0]['attributes']?['name'] ?? 'No name available'}");
      } else {
        log("No data available in response");
      }

      final Map<String, dynamic> parsed = Japx.decode(decodedJson);
      log("Parsed JSON after Japx: $parsed");

      GetChatProfileResponse authUser = GetChatProfileResponse.fromJson(parsed);

      return {
        'status': true,
        'message': 'successful',
        'allchatdata': authUser.data,
      };
    } else {
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      log("Error Response: $parsed");
      return {'status': false, 'message': parsed['error'] ?? 'Failed to fetch data'};
    }
  } catch (e, stackTrace) {
    log("Error in fetchallchats: $e\nStackTrace: $stackTrace");
    return {'status': false, 'message': 'Error: $e'};
  }
}





 Future<Map<String, dynamic>> getsinglechat(String id, int userid) async {
  try {
    String? token = await Store.getUserid();
    final response = await http.get(
      Uri.parse("${baseurl}chat/chat-messages/queries/chat-between-users/$id/$userid"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("HTTP Status Code: ${response.statusCode}");
    log("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      log("Decoded JSON: $decodedJson");


    
      final Map<String, dynamic> parsed = Japx.decode(decodedJson);
      log("Parsed JSON after Japx: $parsed");

      GetSingleChatModel authUser = GetSingleChatModel.fromJson(parsed);

      return {
        'status': true,
        'message': 'successful',
        'singlechat': authUser.data,
      };
    } else {
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      log("Error Response: $parsed");
      return {'status': false, 'message': parsed['error'] ?? 'Failed to fetch data'};
    }
  } catch (e, stackTrace) {
    log("Error in fetchallchats: $e\nStackTrace: $stackTrace");
    return {'status': false, 'message': 'Error: $e'};
  }
}
}
