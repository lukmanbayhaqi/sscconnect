import 'package:sscconnect/models/appuser.dart';

class User {
  int? id;
  String? name;
  String? title;
  String? nickName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? userName;
  bool? emailConfirmed;
  String? gender;
  String? birthDate;
  bool? changeableName;
  bool? changeableGender;
  bool? changeableBirthDate;
  String? imageUrl;
  AppUser? appUser;

  User({
    this.id,
    this.name,
    this.title,
    this.nickName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.userName,
    this.emailConfirmed,
    this.gender,
    this.birthDate,
    this.changeableName,
    this.changeableGender,
    this.changeableBirthDate,
    this.imageUrl,
    this.appUser,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    title = json['Title'];
    nickName = json['NickName'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    userName = json['UserName'];
    emailConfirmed = json['EmailConfirmed'];
    gender = json['Gender'];
    birthDate = json['BirthDate'];
    changeableName = json['ChangeableName'];
    changeableGender = json['ChangeableGender'];
    changeableBirthDate = json['ChangeableBirthDate'];
    imageUrl = json['ImageUrl'];
    appUser =
        json['AppUser'] != null ? AppUser.fromJson(json['AppUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Id'] = id;
    data['Name'] = name;
    data['Title'] = title;
    data['NickName'] = nickName;
    data['FirstName'] = firstName;
    data['MiddleName'] = middleName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['UserName'] = userName;
    data['EmailConfirmed'] = emailConfirmed;
    data['Gender'] = gender;
    data['BirthDate'] = birthDate;
    data['ChangeableName'] = changeableName;
    data['ChangeableGender'] = changeableGender;
    data['ChangeableBirthDate'] = changeableBirthDate;
    data['ImageUrl'] = imageUrl;

    if (appUser != null) {
      data['AppUser'] = appUser!.toJson();
    }

    return data;
  }
}
