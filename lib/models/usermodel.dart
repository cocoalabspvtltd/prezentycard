import 'package:prezentycardmodule/models/user.dart';


class UserSignUpResponse {
  bool? success;
  int? statusCode;
  String? message;
  User? user;
  String? token;

  UserSignUpResponse(
      {this.success, this.statusCode, this.message, this.user, this.token});

  UserSignUpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String? email;
  String? phone;
  String? name;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profilePhotoUrl;

  User(
      {this.email,
        this.phone,
        this.name,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}