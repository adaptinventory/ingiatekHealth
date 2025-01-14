import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchpointhealth/appstate/AppState.dart';
import 'package:touchpointhealth/dashboard/screen/DashBoardScreen.dart';

import '../Utils/AppFonts.dart';
import '../Utils/AppImages.dart';
import '../Utils/AppLocalization.dart';
import '../Utils/ColorUtils.dart';
import 'model/PatientModel.dart';

class VerficationScreen  extends StatefulWidget {

  @override
  State<VerficationScreen> createState() => _VerficationScreenState();

}
class _VerficationScreenState extends State<VerficationScreen> {
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';
  bool enalbeButton = true;
  bool logingIn = false;
  bool loginFail = false;

  TextStyle getUnderLineStyle(){
    return TextStyle(
      shadows: [
        Shadow(
            color: ColorUtils.weldonBlue,
            offset: Offset(0, -1))
      ],
      fontFamily: AppFonts.firaSans,
      fontSize: AppFonts.getAdjustedFontSize(context, 10,maxSize: 14),
      height: 1.9,
      fontWeight: FontWeight.w500,
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: ColorUtils.weldonBlue,
    );
  }

  void logIn() async{
    if(passwordController.text.isEmpty){
      errorMessage = AppLocalizations.of(context)!.translate('verify.error');
      setState(() {
        loginFail = true;
      });
      return;
    }
    setState(() {
      logingIn = true;
    });

      PatientModel? patientModel  = AppState().patient;
      //Got patient details
      // Move to dashboard screen
    if(patientModel != null) {
      String dob = DateFormat('yyyy-MM-dd').format(patientModel.dateOfBirth);
      if (dob == passwordController.text) {
        //_rememberMe("", dob, true);
        loggedIn();
      }else{
        errorMessage = AppLocalizations.of(context)!.translate('verify.error');
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
      //await prefs.setString('username', username);
      await prefs.setString('password', password);
    }
  }

  void loggedIn(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashBoardScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        decoration: const BoxDecoration(
          color: ColorUtils.bgColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 40),
                child: Image.asset(AppImages.blueLogo),
              ),
              const SizedBox(height: 100,),
              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 30,right: 10),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text('Welcome',
                          style: TextStyle(
                              color: ColorUtils.weldonBlue,
                              fontFamily: AppFonts.firaSans,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
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
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(AppLocalizations.of(context)!.translate('verify.dob'),
                          style: TextStyle(
                              color: ColorUtils.weldonBlue,
                              fontFamily: AppFonts.firaSans,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: AppFonts.getAdjustedFontSize(context, 12,maxSize: 16)
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
                          keyboardType: TextInputType.datetime,
                          controller: passwordController,
                          style: TextStyle(
                            color: ColorUtils.weldonBlue,
                            fontFamily: AppFonts.firaSans,
                            fontSize: AppFonts.getAdjustedFontSize(context, 12,maxSize: 16),
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'yyyy-mm-dd',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: AppFonts.firaSans,
                                fontSize: AppFonts.getAdjustedFontSize(context, 12,maxSize: 16),
                                fontWeight: FontWeight.normal,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0)
                          ),
                          onChanged: (value){
                            String newValue = value;
                            if (value.length == 4 || value.length == 7) {
                              if (!value.endsWith('-')) {
                                newValue = '$value-';
                              }
                            }

                            passwordController.value = TextEditingValue(
                              text: newValue,
                              selection: TextSelection.collapsed(offset: newValue.length),
                            );
                            if(value.isNotEmpty){
                              setState(() {
                                enalbeButton = true;
                                errorMessage = '';
                                loginFail = false;
                                logingIn = false;
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
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: AppFonts.firaSans,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.getAdjustedFontSize(context, 12,maxSize: 16)
                  ),
                ) : Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        logIn();
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
                        Text(AppLocalizations.of(context)!.translate('verify.confirm'),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.firaSans,
                                fontStyle: FontStyle.normal,
                                fontSize: AppFonts.getAdjustedFontSize(context, 12,maxSize: 16)
                            )
                        )
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
}}