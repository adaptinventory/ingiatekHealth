// Importing necessary Dart packages and custom modules
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:touchpointhealth/Authentication/model/JWTTokenModel.dart';

import '../appstate/AppState.dart';


// A class responsible for making API requests and handling responses
class ApiManager {
  final String baseUrl = 'https://api.smartmeterrpm.com/';
  final String baseUrlComponent = 'api/';

  // Asynchronous method for making GET requests
  Future<dynamic> get(String endpoint, {String? query}) async {
    Uri uri = Uri.parse(baseUrl + baseUrlComponent + endpoint);
    if (query != null) {
      uri = uri.replace(queryParameters: {'query': query});
    }

    // Retrieving the login response from the application state
    JWTTokenModel? tokenModel = AppState().jwtTokenModel;
    var token = tokenModel?.jwt;

    // Setting up headers with the authorization token if available
    var header = {'Content-Type': 'application/json'};
    //if(token != null){,,,,,,
      header = {'Content-Type': 'application/json',
        'X-API-KEY': AppState().APIKey};
    //}

    // Making the GET request using the http package
    final response = await http.get(uri, headers: header);

    // Printing the response body for debugging purposes
    print('response.body :');
    print(response.body);

    // Decoding and returning the response body
    return json.decode(response.body);
  }

  // Asynchronous method for making POST requests
  Future<dynamic> post(String endpoint, dynamic data, {String? subComponent}) async {
    // Retrieving the login response from the application state
    JWTTokenModel? tokenModel = AppState().jwtTokenModel;
    var token = tokenModel?.jwt;

    // Setting up headers with the authorization token if available
    var header = {'Content-Type': 'application/json'};
    if(token != null){
      header = {'Content-Type': 'application/json',
        'X-API-KEY': AppState().APIKey};
    }

    // Printing data and endpoint for debugging purposes
    print('data: ');
    print(data);
    print('baseUrl + endpoint:');

    // Making the POST request using the http package
    final response = await http.post(
      Uri.parse(baseUrl + (subComponent ?? baseUrlComponent) + endpoint),
      headers: header,
      body: data,
    );

    // Printing the response body for debugging purposes
    print('response.body');
    print(response.body);

    // Decoding and returning the response body
    return json.decode(response.body);
  }

  // Asynchronous method for making PUT requests
  Future<dynamic> put(String endpoint, dynamic data) async {
    // Making the PUT request using the http package
    final response = await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    // Formatting and returning the response
    return _formatResponse(response);
  }

  // Asynchronous method for making DELETE requests
  Future<dynamic> delete(String endpoint) async {
    // Making the DELETE request using the http package
    final response = await http.delete(Uri.parse(baseUrl + endpoint));

    // Formatting and returning the response
    return _formatResponse(response);
  }

  // Helper method to format the http.Response into the desired dynamic type
  dynamic _formatResponse(http.Response response) {
    final body = json.decode(response.body);

    // Checking if the body is a list and returning a list of models if true
    if (body is List) {
      return body.map((e) => _createModel(e)).toList();
    } else {
      // Returning a single model if the body is not a list
      return _createModel(body);
    }
  }

  // Helper method to create a model object from a JSON map
  dynamic _createModel(Map<String, dynamic> json) {
    print(json);

    // Here, you can create and return your data model object from the parsed JSON
    // For example, if you have a TravelReason model, you can create it as follows:
    // return TravelReason.fromJson(json);
    //return TravelReason.fromJson(json);
  }
}
