import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchpointhealth/Utils/AppFonts.dart';
import 'package:touchpointhealth/appbar/SimpleAppBar.dart';
import 'package:touchpointhealth/dashboard/screen/HealthItemDetailScreen.dart';

import '../../Utils/AppImages.dart';
import '../../Utils/AppStrings.dart';
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
              DashboardItemWidget(title: AppStrings.glucose,description: AppStrings.glucoseSubStr,barColor: ColorUtils.sapphireBlue,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder:(context) => const HealthItemDetailScreen(
                  title: AppStrings.glucose,
                  color: ColorUtils.sapphireBlue,
                  itemType: AppStrings.bloodglucoseReadingType,
                )));
              },),
              DashboardItemWidget(title: AppStrings.bloodPr,description: AppStrings.bpSubStr,barColor: ColorUtils.weldonBlue,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) => const HealthItemDetailScreen(
                        title: AppStrings.bloodPr,
                        color: ColorUtils.weldonBlue,
                        itemType: AppStrings.bpReadingType,
                      )));
                },),
              DashboardItemWidget(title: AppStrings.scaleStr,description: AppStrings.weightSubStr,barColor: ColorUtils.vividAmber,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) => const HealthItemDetailScreen(
                        title: AppStrings.scaleStr,
                        color: ColorUtils.vividAmber,
                        itemType: AppStrings.weightReadingType,
                      )));
                },),
              DashboardItemWidget(title: AppStrings.pulseStr,description: AppStrings.pulseOXSubStr,barColor: ColorUtils.blue,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) => const HealthItemDetailScreen(
                        title: AppStrings.pulseStr,
                        color: ColorUtils.blue,
                        itemType: AppStrings.pulseReadingType,
                      )));
                },),

            ],
          ),
        ),
      ),
    );
  }
}

