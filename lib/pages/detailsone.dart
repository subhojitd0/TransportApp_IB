// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ibapp_2/pages/loginpage.dart';
import 'package:ibapp_2/pages/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsOne extends StatelessWidget {
  var id = 0;
  var name = '';
  var phone = '';
  var startloc = '';
  var starttime = '';
  var endloc = '';
  var endtime = '';
  DetailsOne(v, {super.key}) {
    id = v.id;
    phone = v.phone;
    name = v.name;
    startloc = v.startloc;
    starttime = v.starttime;
    endloc = v.endloc;
    endtime = v.endtime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Details'),
          // leading: GestureDetector(
          //   onTap: () {/* Write listener code here */},
          //   child: const Icon(
          //     Icons.menu, // add custom icons also
          //   ),
          // ),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    logout();
                    if (SplashScreenState.loginKey == '') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }
                  },
                  child: const Icon(
                    Icons.logout,
                    size: 26.0,
                  ),
                )),
          ]),
      body: Column(
        children: [Text(name)],
      ),
    );
  }
}

void logout() async {
  var sharedpref = await SharedPreferences.getInstance();
  await sharedpref.clear();
  sharedpref.setString(SplashScreenState.loginKey, '');
}
