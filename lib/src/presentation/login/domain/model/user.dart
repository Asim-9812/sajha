

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject{

  @HiveField(0)
  int userID;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String? gender;

  @HiveField(4)
  String? dateOfBirth;

  @HiveField(5)
  String? address;

  @HiveField(6)
  String? contact;

  @HiveField(7)
  String email;

  @HiveField(8)
  bool status;

  @HiveField(9)
  String? profilePicName;

  @HiveField(10)
  String? profileUrl;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileUrl,
    required this.status,
    this.dateOfBirth,
    this.address,
    this.contact,
    this.gender,
    this.profilePicName
  });

  factory User.empty(){
    return User(
      userID: 1,
      firstName: '',
      lastName: '',
      email: '',
      address: null,
      contact: null,
      dateOfBirth: null,
      gender: null,
      status: false,
      profilePicName: null,
      profileUrl: null,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      firstName: json['fName'],
      lastName: json['lName'],
      email: json['email'],
      address: json['address'],
      contact: json['contact'],
      dateOfBirth: json['dob'],
      gender: json['gender'],
      status: json['status'],
      profilePicName: json['profilePicName'],
      profileUrl: json['profilePicUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['fName'] = firstName;
    data['lName'] = lastName;
    data['gender'] = gender;
    data['dob'] = dateOfBirth;
    data['address'] = address;
    data['contact'] = contact;
    data['email'] = email;
    data['status'] = status;
    data['profilePicName'] = profilePicName;
    data['profilePicUrl'] = profileUrl;
    return data;
  }


}
