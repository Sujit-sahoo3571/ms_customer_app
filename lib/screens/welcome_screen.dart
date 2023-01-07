// ignore_for_file: avoid_print

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ms_customer_app/loginscreen/customer_login.dart';
import 'package:ms_customer_app/loginscreen/customer_signup_page.dart';
import 'package:ms_customer_app/widgets/button_animlogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screen.dart';

const kcolorizedColors = [
  Colors.purple,
  Colors.yellow,
  Colors.blue,
  Colors.red,
];
const ktextStyle = TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const welcomeRouteName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isLoading = false;
  String customerId = "";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();

    _prefs.then((SharedPreferences prefs) {
      return prefs.getString("customerId") ?? "";
    }).then((String value) {
      setState(() {
        customerId = value;
      });
      print(customerId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 60.0,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('MULTI STORE',
                        textStyle: ktextStyle, colors: kcolorizedColors),
                    ColorizeAnimatedText(' WELCOME ',
                        textStyle: ktextStyle, colors: kcolorizedColors),
                  ],
                  repeatForever: true,
                ),
              ),
              const SizedBox(
                height: 120.0,
                width: 200.0,
              ),
              SizedBox(
                height: 80.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText("BUY"),
                      RotateAnimatedText("SELL"),
                      RotateAnimatedText("SHOP"),
                      RotateAnimatedText("MULTI STORE"),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60.0,
                    width: screensize.width * 0.8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                      color: Colors.white54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerYellowButton(
                          label: 'SignUp',
                          width: 0.25,
                          onpressed: () => Navigator.pushReplacementNamed(
                              context, CustomerSignUpScreen.signUpRouteName),
                        ),
                        ContainerYellowButton(
                          label: 'LogIn',
                          width: 0.25,
                          onpressed: () {
                            customerId != ""
                                ? Navigator.pushReplacementNamed(
                                    context, OnBoardingScreen.onboarding)
                                : Navigator.pushReplacementNamed(context,
                                    CustomerLogInScreen.signInRoutName);
                          },
                        ),
                        AnimatedLogo(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
