import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ibapp_2/pages/loginpage.dart';
import 'package:ibapp_2/pages/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UpcomingDuty extends StatefulWidget {
  const UpcomingDuty({super.key});

  @override
  State<UpcomingDuty> createState() => _UpcomingDutyState();
}

class DutyList {
  final int id;
  final String name;
  final String phone;
  final String startloc;
  final String endloc;
  final String starttime;
  final String endtime;

  DutyList(
      {this.id = 0,
      this.name = '',
      this.phone = '',
      this.startloc = "",
      this.endloc = "",
      this.starttime = "",
      this.endtime = ""});
}

class _UpcomingDutyState extends State<UpcomingDuty> {
  List<DutyList> dutylist = [];
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("Hello");
      var uri = Uri.parse('https://wishwings.in/api/appdutylist.php');
      Response response =
          await post(uri, body: convert.jsonEncode({"count": "4"}));

      if (response.statusCode == "200") {
        var responseData = convert.jsonDecode(response.body);

        for (var d in responseData) {
          dutylist.add(DutyList(
              id: d["id"],
              name: d["name"],
              phone: d["phone"],
              startloc: d["startloc"],
              endloc: d["endloc"],
              starttime: d["starttime"],
              endtime: d["endtime"]));
        }
        // print(dutylist[0].phone);
      } else {
        print("ISSUE");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //var demoarray = ['Ram', 'Tara', 'Kajol', 'Giva', 'Rohan'];
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          ListView.builder(
              itemBuilder: (context, index) {
                return Text(
                  dutylist[index].name,
                  style: const TextStyle(color: Colors.deepOrange),
                );
              },
              itemCount: dutylist.length),
          Center(
            child: ElevatedButton(
              onPressed: () {
                logout();
                if (SplashScreenState.loginKey == '') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              },
              child: const Text('Press Me'),
            ),
          ),
        ]));
  }
}

void logout() async {
  var sharedpref = await SharedPreferences.getInstance();
  await sharedpref.clear();
  sharedpref.setString(SplashScreenState.loginKey, '');
}
