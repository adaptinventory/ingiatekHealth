
import 'dart:convert';
import 'dart:ffi';

class BaseAPIModel {
  int status;
  String message;

  BaseAPIModel({required this.status, required this.message});

  factory BaseAPIModel.fromJson(Map<String, dynamic> json) {
    return BaseAPIModel(
      status: json['code'],
      message: json['message'],
    );
  }
}

