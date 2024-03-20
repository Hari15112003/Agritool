class UserModel {
  String name;
  // String email;
  String phoneNumber;
  String uid;
  String createdAt;
  String state;
  String district;
  String pincode;
  String age;
  String gender;

  UserModel(
      {required this.name,
      required this.gender,
      // required this.email,
      required this.age,
      required this.district,
      required this.pincode,
      required this.createdAt,
      required this.phoneNumber,
      required this.uid,
      required this.state});

  // From map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        state: map['state'] ?? '',
        pincode: map['pincode'] ?? '',
        gender: map['gender'] ?? '',
        name: map['name'] ?? '',
        // email: map['email'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        createdAt: map['createdAt'] ?? '',
        district: map['district'] ?? '',
        uid: map['uid'] ?? '',
        age: map['age'] ?? '');
  }
  // To map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'email': email,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'gender': gender,
      'age': age,
      'state': state,
      'district': district,
      'pincode': pincode,
      'createdAt': createdAt
    };
  }
}
