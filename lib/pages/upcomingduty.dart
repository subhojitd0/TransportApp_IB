import 'package:flutter/material.dart';
import 'package:ibapp_2/pages/loginpage.dart';
import 'package:ibapp_2/pages/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingDuty extends StatelessWidget {
  const UpcomingDuty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const SizedBox(height: 200),
        const Text(
          'UPCOMING DUTY',
          style: TextStyle(fontSize: 25, color: Colors.red),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            logout();
            if (SplashScreenState.loginKey == '') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          },
          child: const Text('Press Me'),
        ),
      ],
    )));
  }
}

void logout() async {
  var sharedpref = await SharedPreferences.getInstance();
  sharedpref.setString(SplashScreenState.loginKey, '');
}
