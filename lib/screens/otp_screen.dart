import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../contants.dart';
import '../model/otp_response.dart';
import '../provider/commonviewmodel.dart';
import '../widgets/widget_botton.dart';
import 'home_screen.dart';

class OtpScreen extends StatelessWidget {
  final String phonenumber;
  final int? otp;
  OtpScreen({super.key, required this.phonenumber, required this.otp});
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: TextStyle(fontSize: 20, color: Colors.black),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    ),
  );
  String _enteredOtp = '';
  CommonViewModel? vm;
  OtpResponse? responsedatafromotp;
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
      backgroundColor: Appcolor().backgroundColor,
      body: Consumer<CommonViewModel>(builder: (context, courses, child) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/back-button.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "Enter your verification\ncode",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Space.h20,
                        Space.h15,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: RichText(
                              text: TextSpan(
                                text: phonenumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '  Edit',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Space.h10,
                        Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          onCompleted: (pin) {
                            _enteredOtp = pin;
                          },
                        ),
                        Space.h15,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Didn’t get anything? No worries, let’s try again.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              vm!.registrationloading
                                  ? Center(child: CircularProgressIndicator())
                                  : InkWell(
                                      onTap: () {
                                        vm!
                                            .sendotp(
                                          phonenumber,
                                        )
                                            .then((value) {
                                          if (vm!.responsedata.status == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    vm!.responsedata.message!),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Something went wrong'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );

                                            return;
                                          }
                                        });
                                      },
                                      child: Text(
                                        "Resent",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: vm!.otpconfirmloading
              ? Container(
                
                height:50,
                child: Center(child: CircularProgressIndicator()))
              : WidgetBotton(
                  title: 'Next',
                  titlecolor: Colors.white,
                  color: Appcolor().primaryColor,
                  onTap: () {
                    if (_enteredOtp.isEmpty || _enteredOtp.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Please enter a valid 6-digit OTP")),
                      );
                      return;
                    }
                    vm!
                        .confirmotpsent(
                      phonenumber,
                      111111,
                    )
                        .then((value) {
                      if (vm!.confirmotp != null &&
                          vm!.responsedatafromotp != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid or expired OTP')),
                        );
                      }
                    });
                  },
                ),
        ),
      ),
    );
  }
}
