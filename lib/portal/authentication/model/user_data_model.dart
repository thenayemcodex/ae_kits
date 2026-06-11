class UserDataModel {
  final String id;
  final String eid;
  final String username;
  final String fullname;
  final String email;
  final String mobile;
  final String position;
  final String zone;
  final String location;
  final int dutyStart;
  final int dutyEnd;
  final int accessPriority;
  final bool status;

  UserDataModel({
    required this.id,
    required this.eid,
    required this.username,
    required this.fullname,
    required this.email,
    required this.mobile,
    required this.position,
    required this.zone,
    required this.location,
    required this.dutyStart,
    required this.dutyEnd,
    required this.accessPriority,
    required this.status,
  });

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'],
      eid: map['eid'],
      username: map['username'],
      fullname: map['fullname'],
      email: map['email'],
      mobile: map['mobile'],
      position: map['position'],
      zone: map['zone'],
      location: map['location'],
      dutyStart: map['duty_start'],
      dutyEnd: map['duty_end'],
      accessPriority: map['access_priority'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eid': eid,
      'username': username,
      'fullname': fullname,
      'email': email,
      'mobile': mobile,
      'position': position,
      'zone': zone,
      'location': location,
      'duty_start': dutyStart,
      'duty_end': dutyEnd,
      'access_priority': accessPriority,
      'status': status,
    };
  }

  UserDataModel copyWith({
    String? id,
    String? eid,
    String? username,
    String? fullname,
    String? email,
    String? mobile,
    String? position,
    String? zone,
    String? location,
    int? dutyStart,
    int? dutyEnd,
    int? accessPriority,
    bool? status,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      eid: eid ?? this.eid,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      position: position ?? this.position,
      zone: zone ?? this.zone,
      location: location ?? this.location,
      dutyStart: dutyStart ?? this.dutyStart,
      dutyEnd: dutyEnd ?? this.dutyEnd,
      accessPriority: accessPriority ?? this.accessPriority,
      status: status ?? this.status,
    );
  }
}
