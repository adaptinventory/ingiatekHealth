import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/AppFonts.dart';
import '../../Utils/ColorUtils.dart';

class DashboardItemWidget extends StatelessWidget{

  final Color barColor;
  final String title;
  final String description;
  final VoidCallback onPressed;

  DashboardItemWidget({super.key, required this.title,required this.description,required this.barColor, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: (){
         onPressed();
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7), // Match the container's borderRadius
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                  height: 95,
                  child: ColoredBox(color: barColor,),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: const TextStyle(
                          color: ColorUtils.sapphireBlue,
                          fontFamily: AppFonts.bwMitga,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    Text(description,
                      style: const TextStyle(
                          color: ColorUtils.darkGray,
                          fontFamily: AppFonts.firaSans,
                          fontWeight: FontWeight.normal,
                          fontSize: 15
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}