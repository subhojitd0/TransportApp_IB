import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ibapp_2/models/dutylist.dart';

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
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getduty(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('Loading.....');
                    } else {
                      return ListView.builder(
                          itemCount: dl.length,
                          itemBuilder: (context, index) {
                            return Text(dl[index].name.toString());
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
