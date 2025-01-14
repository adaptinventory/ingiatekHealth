import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchpointhealth/appbar/SimpleAppBar.dart';
import 'package:touchpointhealth/dashboard/screen/HealthItemDetailScreen.dart';

import '../../Utils/AppImages.dart';
import '../../Utils/AppLocalization.dart';
import '../../Utils/ColorUtils.dart';
import '../widgets/DashboardItemWidget.dart';

class DashBoardScreen extends StatefulWidget{
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SimpleAppbar(width: 80,),
      body: Container(
        height: deviceSize.height,
          decoration: const BoxDecoration(
              color: ColorUtils.sapphireBlue
          ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Image.asset(AppImages.logoWhitePNG),//SvgPicture.asset(AppImages.logoLongBlue, color: Colors.white,),
              ),
              const SizedBox(height: 40,),
              DashboardItemWidget(title:AppLocalizations.of(context)!.translate('dashboard.glucose'),description:AppLocalizations.of(context)!.translate('descriptions.glucose_sub') ,barColor: ColorUtils.sapphireBlue,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder:(context) => HealthItemDetailScreen(
                  title: AppLocalizations.of(context)!.translate('dashboard.glucose'),
                  color: ColorUtils.sapphireBlue,
                  itemType: AppLocalizations.of(context)!.translate('reading_types.blood_glucose'),
                )));
              },),
              DashboardItemWidget(title:AppLocalizations.of(context)!.translate('dashboard.blood_pressure'),description:AppLocalizations.of(context)!.translate('descriptions.blood_pressure_sub'),barColor: ColorUtils.weldonBlue,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) => HealthItemDetailScreen(
                        title: AppLocalizations.of(context)!.translate('dashboard.blood_pressure'),
                        color: ColorUtils.weldonBlue,
                        itemType: AppLocalizations.of(context)!.translate('reading_types.blood_pressure'),
                      )));
                },),
              DashboardItemWidget(title:AppLocalizations.of(context)!.translate('dashboard.scale'),description:AppLocalizations.of(context)!.translate('descriptions.scale_sub') ,barColor: ColorUtils.vividAmber,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) => HealthItemDetailScreen(
                        title: AppLocalizations.of(context)!.translate('dashboard.scale'),
                        color: ColorUtils.vividAmber,
                        itemType: AppLocalizations.of(context)!.translate('reading_types.weight'),
                      )));
                },),
              DashboardItemWidget(title:AppLocalizations.of(context)!.translate('dashboard.pulse_ox'),description:AppLocalizations.of(context)!.translate('descriptions.pulse_ox_sub'),barColor: ColorUtils.blue,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) => HealthItemDetailScreen(
                        title: AppLocalizations.of(context)!.translate('dashboard.pulse_ox'),
                        color: ColorUtils.blue,
                        itemType:AppLocalizations.of(context)!.translate('reading_types.pulse'),
                      )));
                },),

            ],
          ),
        ),
      ),
    );
  }
}

