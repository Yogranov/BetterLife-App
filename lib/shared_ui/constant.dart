class Constant {

  static final String apiToken = "";

  static String calculateRiskLevel(int percent) {
    String risk;
    if(percent < 20)
      risk = "הכל נראה בסדר";
    else if(percent >= 21 && percent <= 30)
      risk = "אין חשש אך מומלץ להמשיך מעקב";
    else if(percent >= 31 && percent <= 60)
      risk = "למערכת היה קשה לזהות, נא להמתין לאבחון הרופא";
    else if(percent >= 61 && percent < 79)
      risk = "קיים חשש, מומלץ לקבוע בהקדם";
    else 
      risk = "קיים חשש מיידי, נא לפנות לרופא בהקדם";

    return risk;
  }

}