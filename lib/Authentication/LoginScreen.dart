import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchpointhealth/Authentication/model/JWTTokenModel.dart';
import 'package:touchpointhealth/Authentication/model/PatientModel.dart';
import 'package:touchpointhealth/Authentication/service/LoginService.dart';
import 'package:touchpointhealth/Utils/AppFonts.dart';
import 'package:touchpointhealth/Utils/AppImages.dart';
import 'package:touchpointhealth/Utils/ColorUtils.dart';
import 'package:touchpointhealth/appstate/AppState.dart';
import 'package:touchpointhealth/dashboard/screen/DashBoardScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'VerficationScreen.dart';

class LoginPasswordScreen extends StatefulWidget{
  const LoginPasswordScreen({super.key});

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';
  bool enalbeButton = true;
  bool logingIn = false;
  bool loginFail = false;
  bool isPreviousLogin = false;

  String dropdownValue = "No Provider";
  
  List<String> list =["No Provider","Evexia Weight loss & Wellness"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController.text = '';
    _checkRememberMe();
  }

  TextStyle getUnderLineStyle(){
    return const TextStyle(
        shadows: [
          Shadow(
              color: ColorUtils.weldonBlue,
              offset: Offset(0, -1))
        ],
        fontFamily: AppFonts.firaSans,
        fontSize: 10,
        height: 1.9,
        fontWeight: FontWeight.w500,
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        decorationColor: ColorUtils.weldonBlue,
    );
  }

  void logIn(String patientId) async{
    if(patientId.isEmpty){

      errorMessage = 'Please enter valid patient ID';
      setState(() {
        loginFail = true;
        logingIn =  false;
      });
      return;
    }
    //Perform login request
    var loginService = LoginService();
    setState(() {
      logingIn = true;
    });
    if(dropdownValue == 'Evexia Weight loss & Wellness'){
      //Update API key for Evexia group
      AppState().APIKey = "37c4b53f2ba5db022ad723b9b7cf363617bdafb82334e2cf8a25760e832bc510";
    }else{
      AppState().APIKey = "84d92feaf5dc31c6ed1a573844948a7abe0bd5b928fdb4be40cd352255867681";
    }
    JWTTokenModel? token = await loginService.getJWTToken();

    if(token != null){
      PatientModel? patientModel  = await  loginService.getPatient(patientId);
      //Got patient details
      // Move to dashboard screen
      if(patientModel != null) {
        _rememberMe(patientId, "", true);
        AppState().patient = patientModel;
        loggedIn();
      }else{
        //No Patient info, must be some error
        errorMessage = 'Please enter valid patient ID';
        setState(() {
          loginFail = true;
          logingIn = false;
        });
      }
    }

  }

  Future<void> _rememberMe(String username, String password, bool rememberMe) async {
    if (rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      //await prefs.setString('password', password);
    }
  }

  Future<void> _checkRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username != null) {
      // Automatically log in with stored credentials
      setState(() {
        isPreviousLogin = true;
      });

      logIn(username);
    }
  }


  void loggedIn(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  isPreviousLogin == true ? DashBoardScreen() : VerficationScreen(),
      ),
    );
  }

  _launchURL(urlStr) async {
    final Uri url = Uri.parse(urlStr);
    if (!await launchUrl(url,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var padding = (deviceSize.width - 330)/2;
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        decoration: const BoxDecoration(
          color: ColorUtils.bgColor,
        ),
        child: isPreviousLogin == true ?  const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: ColorUtils.weldonBlue,
              ),
            ],
          ),
        ) : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 40),
                child: Image.asset(AppImages.blueLogo),
              ),
              const SizedBox(height: 100,),
              /*
              **  Not required any more.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: ColorUtils.sapphireBlue,width: 2),
                  ),
                  height: 50,
                  padding: const EdgeInsets.only(left: 30,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text('Select Provider:',
                          style: TextStyle(
                              color: ColorUtils.weldonBlue,
                              fontFamily: AppFonts.firaSans,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          value: dropdownValue,
                          isDense: true,
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                              errorMessage=  '';
                            });
                          },
                          items: list.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: ColorUtils.weldonBlue,
                                  fontFamily: AppFonts.firaSans,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                )),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) {
                            return list.map<Widget>((String value) {
                              return Text(
                                dropdownValue,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: ColorUtils.weldonBlue,
                                  fontFamily: AppFonts.firaSans,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50,),*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: ColorUtils.sapphireBlue,width: 2),
                  ),
                  height: 50,
                  padding: const EdgeInsets.only(left: 30,right: 10),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text('Member ID:',
                          style: TextStyle(
                              color: ColorUtils.weldonBlue,
                              fontFamily: AppFonts.firaSans,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: deviceSize.width - 230,
                        child: TextField(
                          maxLines: 1,
                          cursorColor: ColorUtils.weldonBlue,
                          cursorHeight: 18,
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          style: const TextStyle(
                            color: ColorUtils.weldonBlue,
                            fontFamily: AppFonts.firaSans,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0)
                          ),
                          onChanged: (value){
                            if(value.isNotEmpty){
                              setState(() {
                                enalbeButton = true;
                                errorMessage = '';
                                loginFail = false;
                              });
                            }else{
                              setState(() {
                                enalbeButton = false;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: errorMessage.isNotEmpty ? Text(errorMessage,
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontFamily: AppFonts.firaSans,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 12
                  ),
                ) : Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        logIn(passwordController.text);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: ColorUtils.sapphireBlue,
                            borderRadius: BorderRadius.all(Radius.circular(25))
                        ),
                        height: 50,
                        width: deviceSize.width - 80,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(child:
                        logingIn == true ?
                        const CircularProgressIndicator(color: ColorUtils.weldonBlue,) :
                        const Text("CONTINUE",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppFonts.firaSans,
                              fontStyle: FontStyle.normal,
                              fontSize: 12
                          )
                        )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Contact Administrator',
                      style: getUnderLineStyle(),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          //Handle tap
                          //jaxmdg@gmail.com
                          _launchURL('mailto:jaxmdg@gmail.com');
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}