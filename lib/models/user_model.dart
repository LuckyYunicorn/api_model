class MeModel {
  String? message;
  Data? data;
  String? timestamp;

  MeModel({this.message, this.data, this.timestamp});

  MeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? statusId;
  String? languageCode;
  Null? languageId;
  Null? fileUrl;
  int? roleId;
  String? contactNo;
  Null? dateOfBirth;
  Null? gender;
  Null? state;
  Null? city;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.statusId,
        this.languageCode,
        this.languageId,
        this.fileUrl,
        this.roleId,
        this.contactNo,
        this.dateOfBirth,
        this.gender,
        this.state,
        this.city});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    statusId = json['statusId'];
    languageCode = json['languageCode'];
    languageId = json['languageId'];
    fileUrl = json['fileUrl'];
    roleId = json['roleId'];
    contactNo = json['contactNo'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['statusId'] = this.statusId;
    data['languageCode'] = this.languageCode;
    data['languageId'] = this.languageId;
    data['fileUrl'] = this.fileUrl;
    data['roleId'] = this.roleId;
    data['contactNo'] = this.contactNo;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}
