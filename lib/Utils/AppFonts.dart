import 'package:flutter/cupertino.dart';

class AppFonts{
  //Font  Family
  static const String firaSans        = 'FiraSans';
  static const String bwMitga         = 'BwMitga';


  static double getAdjustedFontSize(BuildContext context, double originalFontSize, {double maxSize = 32.0}) {
    TextScaler textScaler = MediaQuery.of(context).textScaler;
    double textScaleFactor = textScaler.scale(originalFontSize);
    //double adjustedFontSize = originalFontSize * textScaleFactor;
    if(textScaleFactor ==  originalFontSize){
      return originalFontSize;
    }
    if(textScaleFactor > originalFontSize){
      double factor = originalFontSize / textScaleFactor;
      textScaleFactor = originalFontSize * (0.7+(factor/2));
    }
    // Ensure the font size does not exceed the maximum size
    if (textScaleFactor > maxSize) {
      textScaleFactor = maxSize;
    }

    return textScaleFactor;
  }


}