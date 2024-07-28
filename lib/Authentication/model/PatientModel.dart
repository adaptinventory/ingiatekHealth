// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  int patientId;
  String firstName;
  dynamic middleName;
  String lastName;
  String displayName;
  dynamic suffix;
  DateTime dateOfBirth;
  Address shippingAddress;
  Address physicalAddress;
  String emailAddress;
  String? mobilePhone;
  String? homePhone;
  String? language;
  String gender;
  String timezone;
  String messagingPreference;
  String provider;
  dynamic mrn;
  String? consent;
  String? status;
  dynamic careManager;
  int userId;
  List<Device> devices;
  List<dynamic> programs;
  List<dynamic> holds;
  List<dynamic> notes;
  CommunicationPreferences communicationPreferences;

  PatientModel({
    required this.patientId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.displayName,
    required this.suffix,
    required this.dateOfBirth,
    required this.shippingAddress,
    required this.physicalAddress,
    required this.emailAddress,
    required this.mobilePhone,
    required this.homePhone,
    required this.language,
    required this.gender,
    required this.timezone,
    required this.messagingPreference,
    required this.provider,
    required this.mrn,
    required this.consent,
    required this.status,
    required this.careManager,
    required this.userId,
    required this.devices,
    required this.programs,
    required this.holds,
    required this.notes,
    required this.communicationPreferences,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    patientId: json["patient_id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    displayName: json["display_name"],
    suffix: json["suffix"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    shippingAddress: Address.fromJson(json["shipping_address"]),
    physicalAddress: Address.fromJson(json["physical_address"]),
    emailAddress: json["email_address"],
    mobilePhone: json["mobile_phone"],
    homePhone: json["home_phone"],
    language: json["language"],
    gender: json["gender"],
    timezone: json["timezone"],
    messagingPreference: json["messaging_preference"],
    provider: json["provider"],
    mrn: json["mrn"],
    consent: json["consent"],
    status: json["status"],
    careManager: json["care_manager"],
    userId: json["user_id"],
    devices: List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
    programs: List<dynamic>.from(json["programs"].map((x) => x)),
    holds: List<dynamic>.from(json["holds"].map((x) => x)),
    notes: List<dynamic>.from(json["notes"].map((x) => x)),
    communicationPreferences: CommunicationPreferences.fromJson(json["communication_preferences"]),
  );

  Map<String, dynamic> toJson() => {
    "patient_id": patientId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "display_name": displayName,
    "suffix": suffix,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "shipping_address": shippingAddress.toJson(),
    "physical_address": physicalAddress.toJson(),
    "email_address": emailAddress,
    "mobile_phone": mobilePhone,
    "home_phone": homePhone,
    "language": language,
    "gender": gender,
    "timezone": timezone,
    "messaging_preference": messagingPreference,
    "provider": provider,
    "mrn": mrn,
    "consent": consent,
    "status": status,
    "care_manager": careManager,
    "user_id": userId,
    "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
    "programs": List<dynamic>.from(programs.map((x) => x)),
    "holds": List<dynamic>.from(holds.map((x) => x)),
    "notes": List<dynamic>.from(notes.map((x) => x)),
    "communication_preferences": communicationPreferences.toJson(),
  };
}

class CommunicationPreferences {
  dynamic preferredPhoneNumber;
  List<dynamic> preferredDayOfWeek;
  List<dynamic> preferredTimeOfDay;

  CommunicationPreferences({
    required this.preferredPhoneNumber,
    required this.preferredDayOfWeek,
    required this.preferredTimeOfDay,
  });

  factory CommunicationPreferences.fromJson(Map<String, dynamic> json) => CommunicationPreferences(
    preferredPhoneNumber: json["preferred_phone_number"],
    preferredDayOfWeek: List<dynamic>.from(json["preferred_day_of_week"].map((x) => x)),
    preferredTimeOfDay: List<dynamic>.from(json["preferred_time_of_day"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "preferred_phone_number": preferredPhoneNumber,
    "preferred_day_of_week": List<dynamic>.from(preferredDayOfWeek.map((x) => x)),
    "preferred_time_of_day": List<dynamic>.from(preferredTimeOfDay.map((x) => x)),
  };
}

class Device {
  String deviceId;
  String deviceModel;
  DateTime? dateTrained;

  Device({
    required this.deviceId,
    required this.deviceModel,
    this.dateTrained,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    deviceId: json["device_id"],
    deviceModel: json["device_model"],
    dateTrained: json["date_trained"] == null ? null : DateTime.parse(json["date_trained"]),
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "device_model": deviceModel,
    "date_trained": dateTrained?.toIso8601String(),
  };
}

class Address {
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  Address({
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country": country,
  };
}
