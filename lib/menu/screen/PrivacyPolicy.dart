import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchpointhealth/Utils/AppImages.dart';
import 'package:touchpointhealth/appbar/SimpleAppBar.dart';

import '../../Utils/AppLocalization.dart';

class PrivacyPolicy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(backIcon: AppImages.backIcon,),
      body: Container(
        child: Column(
          children: [
            //Text(AppStrings.privacyStr),
            Text(AppLocalizations.of(context)!.translate('privacy_policy.privacy')),
            Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit - Fira-Sans: 18px anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem  incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat")
          ],
        ),
      ),
    );
  }
  
}