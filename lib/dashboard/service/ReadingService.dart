import 'dart:convert';

import 'package:touchpointhealth/dashboard/models/ReadingModel.dart';

import '../../apis/APIManager.dart';
import '../../apis/BaseAPIModel.dart';
import '../../apis/ServiceEndPoints.dart';

class ReadingService {
  Future<ReadingModel?> getReading(int memberId,String dateStart,String dateEnd,String ingestdateStart,String ingestDateEnd,List<String> deviceIds,List<String> readingTypes) async {
    var endPoint  = ServiceEndPoints.readings;
    var body = jsonEncode({
      /*"date_end" : dateEnd,
      "date_start" : dateStart,*/
      "patient_id" : memberId,
      "device_ids" : deviceIds,
      /*"ingest_date_end" : ingestdateStart,
      "ingest_date_start" : ingestDateEnd,*/
      "reading_type" : readingTypes,
    });
    final jsonPayload = await ApiManager().post(
      endPoint,body);
    BaseAPIModel baseResponse = BaseAPIModel.fromJson(jsonPayload['status']);
    if(baseResponse.status == 200){
      //successful response
      ReadingModel readingModel = ReadingModel.fromJson(jsonPayload);
      return readingModel;
    }else {
      throw Exception('Failed to generate  JWT token');
    }
  }
}