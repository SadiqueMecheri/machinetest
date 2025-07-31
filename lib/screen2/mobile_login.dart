import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:machinetest/screen2/otp_screen.dart';
import 'package:provider/provider.dart';

import '../contants.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';
import '../widgets/widget_botton.dart';

class MobileLoginScreen extends StatelessWidget {
  MobileLoginScreen({super.key});

  String? fullPhoneNumber, countrycode;
  CommonViewModel? vm;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
      backgroundColor: Appcolor().backgroundColor,
      body: SafeArea(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Enter your phone \nnumber",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Space.h20,
                        IntlPhoneField(
                          autofocus: false,
                          cursorColor: Appcolor().primaryColor,
                          keyboardType: TextInputType.phone,
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.grey.shade300,
                          ),
                          style: TextStyle(
                            fontSize:
                                15.0 / MediaQuery.textScaleFactorOf(context),
                            color: Colors.black,
                          ),
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            // ✅ Grey border
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade600,
                                width: 1.5,
                              ),
                            ),
                            counterText: '',
                            hintText: "Phone number",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            errorStyle: TextStyle(
                              fontSize:
                                  15.0 / MediaQuery.textScaleFactorOf(context),
                              color: Colors.red.shade900,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 15,
                              bottom: 15,
                            ),
                          ),
                          showCountryFlag: false,
                          dropdownTextStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Appcolor().backgroundColor,
                            countryCodeStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            countryNameStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            padding: EdgeInsets.all(10),
                            searchFieldInputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade100,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Search..",
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade100,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            searchFieldPadding: EdgeInsets.only(top: 10),
                          ),
                          initialCountryCode: 'IN', // Default country
                          validator: (phoneNumber) {
                            if (phoneNumber == null ||
                                phoneNumber.number.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          onChanged: (phone) {
                            fullPhoneNumber = phone.completeNumber;
                            countrycode = phone.countryCode;
                          },
                        ),
                        Space.h10,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Fliq will send you a text with a verification code.",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<CommonViewModel>(builder: (context, courses, child) {
            return vm!.registrationloading
                ? Center(child: CircularProgressIndicator())
                : WidgetBotton(
                    title: 'Next',
                    titlecolor: Colors.white,
                    color: Appcolor().primaryColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        vm!
                            .sendotp(
                          fullPhoneNumber!,
                        )
                            .then((value) {
                          if (vm!.responsedata.status == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(vm!.responsedata.message!),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Store.setLoggedIn("yes");
                            Store.setUsername(fullPhoneNumber!);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return OtpScreen(
                                      phonenumber: fullPhoneNumber!,
                                      otp: vm!.responsedata.data);
                                },
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Something went wrong'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            return;
                          }
                        });
                      }
                    },
                  );
          }),
        ),
      ),
    );
  }
}
