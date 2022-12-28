import 'package:flutter/material.dart';
import 'package:ms_customer_app/loginscreen/customer_login.dart';
import 'package:ms_customer_app/loginscreen/customer_signup_page.dart';
import 'package:ms_customer_app/provider/cart_provider.dart';
import 'package:ms_customer_app/provider/wishlist_product.dart';
import 'package:ms_customer_app/screens/customer_main_screen.dart';
import 'package:ms_customer_app/screens/onboarding_screen.dart';
import 'package:ms_customer_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
    ChangeNotifierProvider(create: (_) => Wish()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Store Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: WelcomeScreen.welcomeRouteName,
      routes: {
        WelcomeScreen.welcomeRouteName: (context) => const WelcomeScreen(),
        CustomerBottomNavigation.customerHomeRouteName: (context) =>
            CustomerBottomNavigation(),
        OnBoardingScreen.onboarding: (context) => const OnBoardingScreen(),
        CustomerLogInScreen.signInRoutName: (context) =>
            const CustomerLogInScreen(),
        CustomerSignUpScreen.signUpRouteName: (context) =>
            const CustomerSignUpScreen(),
      },
    );
  }
}
