import 'package:flutter/material.dart';
import '../contants.dart';
import '../widgets/widget_start_container.dart';
import 'mobile_login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/start-image.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.black87.withOpacity(0.3),
              height: height,
              width: width,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 100),
                        Image.asset(
                          "assets/images/logo.png",
                          height: width / 8,
                        ),
                        Space.h5,
                        Text(
                          "Connect. Meet. Love.\n With Fliq Dating",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        widgetStartContainer(
                          title: "Sign in with Google",
                          icon: "assets/images/google.png",
                          titlecolor: Colors.black,
                          color: Colors.white,
                          onTap: () {},
                        ),
                        Space.h10,
                        widgetStartContainer(
                          title: "Sign in with Facebook",
                          icon: "assets/images/facebook.png",
                          titlecolor: Colors.white,
                          color: Appcolor().facebookColor,
                          onTap: () {},
                        ),
                        Space.h10,
                        widgetStartContainer(
                          title: "Sign in with phone number",
                          icon: "assets/images/phone.png",
                          titlecolor: Colors.white,
                          color: Appcolor().primaryColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MobileLoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                        Space.h20,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'By signing up, you agree to our ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms. ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: 'See how \nwe use your data in our ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
