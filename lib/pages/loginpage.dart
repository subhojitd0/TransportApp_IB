import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibapp_2/pages/splashscreen.dart';
import 'package:ibapp_2/pages/upcomingduty.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

var loginval = 0;

class User {
  final String id;
  final String email;
  final String name;
  final String phone;

  User({
    this.id = "",
    this.email = '',
    this.name = '',
    this.phone = '',
  });
}

TextEditingController useridcnt = TextEditingController();
TextEditingController passwordcnt = TextEditingController();

void login(String userid, password) async {
  var uri = Uri.parse('https://wishwings.in/api/applogin.php');

  Response response = await post(uri,
      body: convert.jsonEncode({"username": userid, "password": password}));

  var responseData = convert.jsonDecode(response.body);

  User user = User(
      id: responseData["id"],
      email: responseData["email"],
      name: responseData["name"],
      phone: responseData["phone"]);

  if (response.statusCode == 200) {
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString(SplashScreenState.loginKey, user.email);
    loginval = 1;
    // print(user.email);
    // print(user.name);
  } else {
    print(response.statusCode);
  }

  // Response resp = await get(Uri.parse('https://reqres.in/api/users/2'));
  // if (resp.statusCode == 200) {
  //   print(resp.body);
  // } else {
  //   print('Fail');
  // }
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://w0.peakpx.com/wallpaper/361/61/HD-wallpaper-blue-amoled-black-s9-s9-plus-thumbnail.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .1,
                    left: MediaQuery.of(context).size.width * .15),
                child: const Text(
                  'Welcome to IB Cabs',
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextField(
                        controller: useridcnt,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Enter the User ID',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: passwordcnt,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Enter the Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: (IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, 'upcomingduty');
                                    login(useridcnt.text.toString(),
                                        passwordcnt.text.toString());

                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      if (loginval == 1) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const UpcomingDuty()));
                                      } else {
                                        showToastErrorMessage(
                                            "Credentials Not Correct");
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_forward))))
                        ],
                      ),
                      const SizedBox(
                        height: 180,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

void showToastErrorMessage(String message) => Fluttertoast.showToast(
      msg: message,
    );
