// Importing necessary Flutter packages and custom modules
import 'package:touchpointhealth/Authentication/model/JWTTokenModel.dart';

import '../Authentication/model/PatientModel.dart';


// A class representing the state of the application
class AppState {
  static final AppState _singleton = AppState._internal();

  JWTTokenModel? jwtTokenModel; // Holds the jwt token
  PatientModel? patient;  // Holds the current login Patient info
  String APIKey = "84d92feaf5dc31c6ed1a573844948a7abe0bd5b928fdb4be40cd352255867681";
      //"37c4b53f2ba5db022ad723b9b7cf363617bdafb82334e2cf8a25760e832bc510";
  factory AppState() {
    return _singleton;
  }

  AppState._internal(); // Private constructor to enforce singleton pattern
}

// A class representing a custom cache manager for the application
/*class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 20), // Setting the stale period for cached items
      maxNrOfCacheObjects: 100, // Setting the maximum number of cached objects
    ),
  );
}*/
