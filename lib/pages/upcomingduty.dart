import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ibapp_2/models/dutylist.dart';
import 'package:ibapp_2/pages/loginpage.dart';
import 'package:ibapp_2/pages/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingDuty extends StatefulWidget {
  const UpcomingDuty({super.key});

  @override
  State<UpcomingDuty> createState() => _UpcomingDutyState();
}

class _UpcomingDutyState extends State<UpcomingDuty> {
  List<DutyList> dl = [];
  Future<List<DutyList>> getduty() async {
    var uri = Uri.parse('https://wishwings.in/api/appdutylist.php');
    final response = await post(uri, body: jsonEncode({"count": "6"}));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        dl.add(DutyList.fromJson(i));
      }
      return dl;
    } else {
      return dl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Duty List'),
          leading: GestureDetector(
            onTap: () {/* Write listener code here */},
            child: const Icon(
              Icons.menu, // add custom icons also
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
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
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getduty(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text(
                        'Loading Data....',
                        style: TextStyle(color: Colors.deepOrange),
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: dl.length,
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 5,
                                shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(dl[index].id.toString()),
                                              Text(dl[index].name.toString()),
                                              // Text(dl[index].phone.toString()),
                                              TextButton(
                                                child: Text(
                                                    dl[index].phone.toString()),
                                                onPressed: () async {
                                                  final Uri url = Uri(
                                                    scheme: 'tel',
                                                    path: dl[index]
                                                        .phone
                                                        .toString(),
                                                  );
                                                  if (await (canLaunchUrl(
                                                      url))) {
                                                    await launchUrl(url);
                                                  } else {
                                                    showToastErrorMessage(
                                                        "Issue with Dialler Setup");
                                                  }
                                                },
                                              )
                                            ]),
                                        Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  "${dl[index].startloc}(${dl[index].starttime})"),
                                              const Text(' - '),
                                              Text(
                                                  "${dl[index].endloc}(${dl[index].endtime})")
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton.icon(
                                                icon: const Icon(Icons.update),
                                                label:
                                                    const Text('Update Duty'),
                                                //child: const Text('Update Duty'),
                                                onPressed: () {},
                                              )
                                            ])
                                      ],
                                    )));
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

void logout() async {
  var sharedpref = await SharedPreferences.getInstance();
  await sharedpref.clear();
  sharedpref.setString(SplashScreenState.loginKey, '');
}
