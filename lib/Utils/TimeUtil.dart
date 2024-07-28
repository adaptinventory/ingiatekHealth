class TimeUtil{
  static DateTime convertToLocalTime(DateTime utcDateTime, double timeZoneOffset) {
    // Parse the date and time string into a DateTime object
    //DateTime utcDateTime = DateTime.parse(dateTimeString);

    // Create a Duration object for the time zone offset
    Duration offsetDuration = Duration(hours: timeZoneOffset.toInt(), minutes: ((timeZoneOffset % 1) * 60).toInt());

    // Adjust the DateTime object by the time zone offset
    DateTime localDateTime = utcDateTime.add(offsetDuration);
    return localDateTime;
    // Return the local time as a formatted string
    //return localDateTime.toString();
  }
}