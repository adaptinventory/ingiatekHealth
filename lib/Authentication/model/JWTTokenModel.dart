// To parse this JSON data, do
//
//     final jwttoken = jwttokenFromJson(jsonString);

import 'dart:convert';

JWTTokenModel jwttokenFromJson(String str) => JWTTokenModel.fromJson(json.decode(str));

String jwttokenToJson(JWTTokenModel data) => json.encode(data.toJson());

class JWTTokenModel {
  String jwt;

  JWTTokenModel({
    required this.jwt,
  });

  factory JWTTokenModel.fromJson(Map<String, dynamic> json) => JWTTokenModel(
    jwt: json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "jwt": jwt,
  };
}
