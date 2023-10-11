class DutyList {
  final int id;
  final String name;
  final String phone;
  final String startloc;
  final String endloc;
  final String starttime;
  final String endtime;

  DutyList(
      {required this.id,
      required this.name,
      required this.phone,
      required this.startloc,
      required this.endloc,
      required this.starttime,
      required this.endtime});

  factory DutyList.fromJson(Map<String, dynamic> json) => DutyList(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      startloc: json['startloc'],
      endloc: json['endloc'],
      starttime: json['starttime'],
      endtime: json['endtime']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'startloc': startloc,
        'endloc': endloc,
        'starttime': starttime,
        'endtime': endtime
      };
}
