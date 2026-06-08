class ProfileModel {
  String uid;
  String username;
  String gmail;
  String mobile;
  String address;
  String lang;
  bool status; 
  bool isBlock;

  ProfileModel({
    required this.uid,
    required this.username,
    required this.gmail,
    required this.mobile,
    required this.address,
    required this.lang,
    required this.status,
    required this.isBlock,
  });

  // copyWith for immutability convenience
  ProfileModel copyWith({
    String? uid,
    String? username,
    String? gmail,
    String? mobile,
    String? address,
    String? lang,
    bool? status,
    bool? isBlock,
  }) {
    return ProfileModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      gmail: gmail ?? this.gmail,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      lang: lang ?? this.lang,
      status: status ?? this.status,
      isBlock: isBlock ?? this.isBlock,
    );
  }

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'gmail': gmail,
      'mobile': mobile,
      'address': address,
      'lang': lang,
      'status': status,
      'isBlock': isBlock,
    };
  }

  // Create object from Map
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      gmail: map['gmail'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
      lang: map['lang'] ?? '',
      status: map['status'] ?? false,
      isBlock: map['isBlock'] ?? false,
    );
  }
}
