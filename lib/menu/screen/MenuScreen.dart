import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchpointhealth/Authentication/LoginScreen.dart';
import 'package:touchpointhealth/Utils/AppFonts.dart';
import 'package:touchpointhealth/Utils/AppImages.dart';
import 'package:touchpointhealth/Utils/ColorUtils.dart';
import 'package:touchpointhealth/appbar/SimpleAppBar.dart';
import 'package:touchpointhealth/appstate/AppState.dart';
import 'package:touchpointhealth/menu/screen/WebViewScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/AppLocalization.dart';

class MenuScreen extends StatefulWidget{
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  TextStyle getButtonTextStyle(){
    return TextStyle(
        color: Colors.white,
      fontFamily: AppFonts.firaSans,
      fontWeight: FontWeight.w500,
      fontSize: AppFonts.getAdjustedFontSize(context, 14,maxSize: 18),
    );
  }

  _launchURL(urlStr) async {
    final Uri url = Uri.parse(urlStr);
    if (!await launchUrl(url,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  logout(BuildContext context) async{
    AppState appState  = AppState();
    appState.jwtTokenModel = null;
    appState.patient  = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.pop(context);
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
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 40),
                child: Text(AppLocalizations.of(context)!.translate('menu.touch_point'),style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppFonts.firaSans,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFonts.getAdjustedFontSize(context, 20,maxSize: 24),
                ),),
              ),
              IconButton(onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
              }, icon: Text(AppLocalizations.of(context)!.translate('menu.dashboard'),
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
              }, icon: Text(AppLocalizations.of(context)!.translate('menu.get_in_touch'),
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
              }, icon: Text(AppLocalizations.of(context)!.translate('menu.terms_conditions'),
                style:getButtonTextStyle(),
              )),
              IconButton(onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(backTitle: "Privacy Policy", url: 'https://ingiatekhealth.com/policies/privacy-policy'),
                  )
                );
              }, icon: Text(AppLocalizations.of(context)!.translate('menu.privacy_policy'),
                style: getButtonTextStyle(),
              )),
              IconButton(onPressed: (){
                _launchURL('https://ingiatekhealth.com');
              }, icon: Text(AppLocalizations.of(context)!.translate('menu.cmag'),
                style: getButtonTextStyle(),)),

              Padding(
                padding: const EdgeInsets.only(left: 40,right: 40,top: 80,bottom: 40),
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
                    child: Center(child: Text(AppLocalizations.of(context)!.translate('menu.logout'),
                      style: TextStyle(
                          color: ColorUtils.sapphireBlue,
                          fontFamily: AppFonts.bwMitga,
                          fontWeight: FontWeight.w600,
                          fontSize: AppFonts.getAdjustedFontSize(context, 15,maxSize: 19)
                      )
                      ,)
                    ),
                  ),
                ),
              ),
              // const SelectLanguage(isSimple: true,)
            ],
          ),
        ),
      ),
    );
  }
}