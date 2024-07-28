// To parse this JSON data, do
//
//     final readingModel = readingModelFromJson(jsonString);

import 'dart:convert';

ReadingModel readingModelFromJson(String str) => ReadingModel.fromJson(json.decode(str));

String readingModelToJson(ReadingModel data) => json.encode(data.toJson());

class ReadingModel {
  List<Reading> reading;

  ReadingModel({
    required this.reading,
  });

  factory ReadingModel.fromJson(Map<String, dynamic> json) => ReadingModel(
    reading: List<Reading>.from(json["data"].map((x) => Reading.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(reading.map((x) => x.toJson())),
  };
}

class Reading {
  int readingId;
  String deviceId;
  String deviceModel;
  DateTime dateRecorded;
  DateTime dateReceived;
  int? diastolicMmhg;
  bool? irregular;
  int? pulseBpm;
  int? systolicMmhg;
  String readingType;
  double timeZoneOffset;
  String? shortCode;
  dynamic qa;
  String imei;
  double? tareKg;
  double? tareLbs;
  double? weightKg;
  double? weightLbs;
  int? spo2;

  Reading({
    required this.readingId,
    required this.deviceId,
    required this.deviceModel,
    required this.dateRecorded,
    required this.dateReceived,
    this.diastolicMmhg,
    this.irregular,
    this.pulseBpm,
    this.systolicMmhg,
    required this.readingType,
    required this.timeZoneOffset,
    this.shortCode,
    required this.qa,
    required this.imei,
    this.tareKg,
    this.tareLbs,
    this.weightKg,
    this.weightLbs,
    this.spo2,
  });

  factory Reading.fromJson(Map<String, dynamic> json) => Reading(
    readingId: json["reading_id"],
    deviceId: json["device_id"],
    deviceModel: json["device_model"],
    dateRecorded: DateTime.parse(json["date_recorded"]),
    dateReceived: DateTime.parse(json["date_received"]),
    diastolicMmhg: json["diastolic_mmhg"],
    irregular: json["irregular"],
    pulseBpm: json["pulse_bpm"],
    systolicMmhg: json["systolic_mmhg"],
    readingType: json["reading_type"],
    timeZoneOffset: json["time_zone_offset"],
    shortCode: json["short_code"],
    qa: json["qa"],
    imei: json["imei"],
    tareKg: json["tare_kg"],
    tareLbs: json["tare_lbs"],
    weightKg: json["weight_kg"]?.toDouble(),
    weightLbs: json["weight_lbs"]?.toDouble(),
    spo2: json["spo2"],
  );

  Map<String, dynamic> toJson() => {
    "reading_id": readingId,
    "device_id": deviceId,
    "device_model": deviceModel,
    "date_recorded": dateRecorded.toIso8601String(),
    "date_received": dateReceived.toIso8601String(),
    "diastolic_mmhg": diastolicMmhg,
    "irregular": irregular,
    "pulse_bpm": pulseBpm,
    "systolic_mmhg": systolicMmhg,
    "reading_type": readingType,
    "time_zone_offset": timeZoneOffset,
    "short_code": shortCode,
    "qa": qa,
    "imei": imei,
    "tare_kg": tareKg,
    "tare_lbs": tareLbs,
    "weight_kg": weightKg,
    "weight_lbs": weightLbs,
    "spo2": spo2,
  };
}
