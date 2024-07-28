import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchpointhealth/Authentication/LoginScreen.dart';
import 'package:touchpointhealth/Utils/AppFonts.dart';
import 'package:touchpointhealth/Utils/AppImages.dart';
import 'package:touchpointhealth/Utils/AppStrings.dart';
import 'package:touchpointhealth/Utils/ColorUtils.dart';
import 'package:touchpointhealth/appbar/SimpleAppBar.dart';
import 'package:touchpointhealth/appstate/AppState.dart';
import 'package:touchpointhealth/menu/screen/PrivacyPolicy.dart';
import 'package:touchpointhealth/menu/screen/WebViewScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatefulWidget{
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  TextStyle getButtonTextStyle(){
    return const TextStyle(
        color: Colors.white,
      fontFamily: AppFonts.firaSans,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  _launchURL(urlStr) async {
    final Uri url = Uri.parse(urlStr);
    if (!await launchUrl(url,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  logout(BuildContext context){
    AppState appState  = AppState();
    appState.jwtTokenModel = null;
    appState.patient  = null;
    Navigator.pushReplacement(context,
        MaterialPageRoute(
          builder: (context) => const LoginPasswordScreen(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SimpleAppbar(backIcon: AppImages.backIcon,),
      body: Container(
        height: deviceSize.height,
        decoration: const BoxDecoration(
          color: ColorUtils.weldonBlue
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20,bottom: 10),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: SvgPicture.asset(AppImages.crossIcon)),
                  )
                ],
              ),
              //SvgPicture.asset(AppImages.logoWhite, color: Colors.white,width: 70,height: 70,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Image.asset(AppImages.logoWhitePNG),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10,bottom: 40),
                child: Text(AppStrings.touchPointStr,style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppFonts.firaSans,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ),
              IconButton(onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
              }, icon: Text(AppStrings.dashBoard,
                style: getButtonTextStyle(),
              )),
              IconButton(onPressed: (){
                _launchURL('https://ingiatekhealth.com/pages/contact');
                /*Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                          backTitle: "Get in touch",
                          url: ''
                      ),
                    )
                );*/
              }, icon: Text(AppStrings.getInTouch,
                style:getButtonTextStyle()
              )),
              IconButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                          backTitle: "Terms & Condition",
                          url: 'https://ingiatekhealth.com/policies/terms-of-service'
                      ),
                    )
                );
              }, icon: Text(AppStrings.termsCond,
                style:getButtonTextStyle(),
              )),
              IconButton(onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(backTitle: "Privacy Policy", url: 'https://ingiatekhealth.com/policies/privacy-policy'),
                  )
                );
              }, icon: Text(AppStrings.privacy,
                style: getButtonTextStyle(),
              )),
              IconButton(onPressed: (){
                _launchURL('https://ingiatekhealth.com');
              }, icon: Text(AppStrings.cmag,
                style: getButtonTextStyle(),)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 80),
                child: GestureDetector(
                  onTap: (){
                    //Handle logout
                    logout(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    height: 50,
                    width: deviceSize.width - 80,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(child: Text(AppStrings.logoutStr,
                      style: TextStyle(
                          color: ColorUtils.sapphireBlue,
                          fontFamily: AppFonts.bwMitga,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                      )
                      ,)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}