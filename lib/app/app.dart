import 'package:flutter/material.dart';
import 'package:ibapp_2/pages/loginpage.dart';
import 'package:ibapp_2/pages/splashscreen.dart';
import 'package:ibapp_2/pages/upcomingduty.dart';

class IbApp extends StatelessWidget {
  const IbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const SplashScreen(),
      initialRoute: 'home',
      routes: {
        'home': (context) => const SplashScreen(),
        'login': (context) => const LoginPage(),
        'upcomingduty': (context) => const UpcomingDuty()
      },
    );
  }
}
