import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:touchpointhealth/Authentication/model/PatientModel.dart';
import 'package:touchpointhealth/Utils/AppImages.dart';
import 'package:touchpointhealth/Utils/TimeUtil.dart';
import 'package:touchpointhealth/appbar/SimpleAppBar.dart';
import 'package:touchpointhealth/appstate/AppState.dart';
import 'package:touchpointhealth/dashboard/models/ReadingModel.dart';
import 'package:touchpointhealth/dashboard/service/ReadingService.dart';

import '../../Utils/AppFonts.dart';
import '../../Utils/AppLocalization.dart';
import '../../Utils/ColorUtils.dart';

class HealthItemDetailScreen extends StatefulWidget{
  final String title;
  final Color color;
  final String itemType;

  const HealthItemDetailScreen({super.key, required this.title, required this.color, required this.itemType});

  @override
  State<HealthItemDetailScreen> createState() => _HealthItemDetailScreenState();
}

class _HealthItemDetailScreenState extends State<HealthItemDetailScreen> {

  bool dataLoaded =  false;
  ReadingModel? dataModel;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    fetchReadings();
  }

  void fetchReadings() async{
    ReadingService service = ReadingService();
    PatientModel? patient =  AppState().patient;
    DateTime now = DateTime.now();
    String startDate = DateFormat('yyyy-MM-dd').format(now.toUtc());
    String endDate = DateFormat('yyyy-MM-dd').format(now.toUtc().subtract(const Duration(days: 30)));
    ReadingModel? model = await service.getReading(patient?.patientId ?? 0,endDate, startDate, '', '', [], [widget.itemType]);
    if(model != null){
      dataModel = model;
      setState(() {
        dataLoaded = true;
      });
    }
  }

  List<Widget>getReadingItems(){
    List<Widget> items = [];
    final dataModel = this.dataModel;
    if(dataModel != null){
      if(dataModel.reading.isEmpty){
        items.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text(AppLocalizations.of(context)!.translate('detail_widget.warning'),
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppFonts.firaSans,
                    fontWeight: FontWeight.normal,
                    fontSize: AppFonts.getAdjustedFontSize(context, 14,maxSize: 18)
                )
            ),
          )
        );
        return items;
      }
      String prevoiusDate ='';
      for(Reading reading in dataModel.reading.reversed){
        String date = DateFormat('MM-dd-yyyy').format(reading.dateRecorded);
        if(date != prevoiusDate) {
          items.add(
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                decoration: BoxDecoration(color: ColorUtils.bgColor),
                child: Row(
                  children: [
                    Text(DateFormat('MM-dd-yyyy').format(reading.dateRecorded),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppFonts.firaSans,
                            fontWeight: FontWeight.normal,
                            fontSize: AppFonts.getAdjustedFontSize(context, 14,maxSize: 18)
                        )
                    ),
                  ],
                ),
              )
          );
        }
        prevoiusDate = date;
        var localTime  = TimeUtil.convertToLocalTime(reading.dateRecorded, reading.timeZoneOffset);
        String time = DateFormat('hh:mm a').format(localTime);
        if(widget.itemType == AppLocalizations.of(context)!.translate('reading_types.weight')){
          items.add(ItemDetailWidget(title: AppLocalizations.of(context)!.translate('detail_widget.weight'), value: '${reading.weightLbs}',time: time,));
        }else if(widget.itemType == AppLocalizations.of(context)!.translate('reading_types.pulse')){
          items.add(ItemDetailWidget(title: AppLocalizations.of(context)!.translate('detail_widget.bo'), value: '${reading.spo2}',time: time));
          items.add(ItemDetailWidget(title: AppLocalizations.of(context)!.translate('detail_widget.pulse'), value: '${reading.pulseBpm}',time: time));
        }else if(widget.itemType == AppLocalizations.of(context)!.translate('reading_types.blood_glucose')){
          //No Sample data
          //items.add(ItemDetailWidget(title: 'Pulse Low (bpm)', value: '${reading.pulseBpm}'));
          //items.add(ItemDetailWidget(title: 'SPO2', value: '${reading.spo2}'));
        }else if(widget.itemType == AppLocalizations.of(context)!.translate('reading_types.blood_pressure')){
          items.add(ItemDetailWidget(title: AppLocalizations.of(context)!.translate('detail_widget.mmg'), value: '${reading.systolicMmhg}/${reading.diastolicMmhg}',time: time));
          //items.add(ItemDetailWidget(title: 'Systolic mmhg', value: '${reading.systolicMmhg}'));
          items.add(ItemDetailWidget(title: AppLocalizations.of(context)!.translate('detail_widget.pulse'), value: '${reading.pulseBpm}',time: time,));
        }
      }
      //items.add(Spacer());
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SimpleAppbar(backIcon: AppImages.backIcon,),
      body: Container(
        width: deviceSize.width,
        decoration: const BoxDecoration(
          color: ColorUtils.bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 7,right: 7,bottom: 50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  ItemTitleWidget(bgColor: widget.color, title: widget.title),
                  dataLoaded == true ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: getReadingItems(),
                      ),
                    ),
                  ) : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                      child: CircularProgressIndicator(color: ColorUtils.sapphireBlue,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemTitleWidget extends StatelessWidget{
  final Color bgColor;
  final String title;

  const ItemTitleWidget({super.key, required this.bgColor, required this.title});
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: 150,
      decoration: BoxDecoration(
        color: bgColor
      ),
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.bwMitga,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.getAdjustedFontSize(context, 38,maxSize: 42)
          ),)
        ],
      ),
    );
  }

}

class ItemDetailWidget extends StatelessWidget{
  final String title;
  final String value;
  final String time;

  const ItemDetailWidget({super.key, required this.title, required this.value,required this.time});
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: 80,
      padding: const EdgeInsets.only(left: 12,right: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(horizontal: BorderSide(color: ColorUtils.bgColor,width: 0.5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(time,
            style: TextStyle(
                color: ColorUtils.darkGray,
                fontFamily: AppFonts.firaSans,
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.getAdjustedFontSize(context, 12,maxSize: 16),
            ),textAlign: TextAlign.left,),
          SizedBox(width: 10,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                  style: TextStyle(
                      color: ColorUtils.darkGray,
                      fontFamily: AppFonts.firaSans,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.getAdjustedFontSize(context, 16,maxSize: 20)
                  ),textAlign: TextAlign.left,),
                Text(value,
                  style: TextStyle(
                      color: ColorUtils.darkGray,
                      fontFamily: AppFonts.firaSans,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.getAdjustedFontSize(context, 16,maxSize: 20)
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }

}