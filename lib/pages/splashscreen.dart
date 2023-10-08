import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibapp_2/pages/loginpage.dart';
import 'package:ibapp_2/pages/upcomingduty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String loginKey = '';
  @override
  void initState() {
    super.initState();
    homeNavigate();
  }

  void homeNavigate() async {
    var sharedperf = await SharedPreferences.getInstance();
    var isLoggedin = sharedperf.getString(loginKey);

    Timer(const Duration(seconds: 3), () {
      if (isLoggedin != '') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UpcomingDuty()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: Center(
              child: Image.network(
                'https://ibcabs.com/bills/assets/img/ib.jpg',
                width: 100,
              ),
              //     Text(
              //   'IB CABS',
              //   style: TextStyle(
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white),
              // )
            )));
  }
}
