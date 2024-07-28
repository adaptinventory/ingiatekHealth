import 'dart:convert';

import 'package:touchpointhealth/Authentication/model/JWTTokenModel.dart';
import 'package:touchpointhealth/Authentication/model/PatientModel.dart';
import 'package:touchpointhealth/apis/BaseAPIModel.dart';
import 'package:touchpointhealth/appstate/AppState.dart';

import '../../apis/APIManager.dart';
import '../../apis/ServiceEndPoints.dart';

class LoginService {
  Future<PatientModel?> getPatient(String memberId) async {
    var endPoint  = ServiceEndPoints.patients + '/$memberId';
    final jsonPayload = await ApiManager().get(
        endPoint,);
    BaseAPIModel baseResponse = BaseAPIModel.fromJson(jsonPayload['status']);
    if(baseResponse.status == 200){
      //successful response
      PatientModel patientModel = PatientModel.fromJson(jsonPayload['data']);
      return patientModel;
    }else {
      return null;
      //throw Exception('Failed to generate  JWT token');
    }
    //LoginModel response = LoginModel.fromJson(jsonPayload);
    //return response;

  }

  Future<JWTTokenModel?> getJWTToken() async {

    final jsonPayload = await ApiManager().get(
        ServiceEndPoints.token);
    BaseAPIModel baseResponse = BaseAPIModel.fromJson(jsonPayload['status']);
    if(baseResponse.status == 200){
      //successful response
      JWTTokenModel jwtToken =JWTTokenModel.fromJson(jsonPayload['data']);
      AppState appState = AppState();
      appState.jwtTokenModel = jwtToken;
      return jwtToken;
    }else {
      throw Exception('Failed to generate  JWT token');
    }
    //LoginModel response = LoginModel.fromJson(jsonPayload);
    //return response;

  }
}