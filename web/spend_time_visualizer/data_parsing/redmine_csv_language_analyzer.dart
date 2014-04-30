part of spend_time_visualizer;

class RedmineCsvLanguageAnalyzer{

  static const Map<String, String> GERMAN_COLUMNS =
      const <String, String> {

    "User" : "Benutzer",
    "Issue": "Ticket",
    "Hours" : "Stunden",
    "Date": "Datum",
    "Seperator": ";"

  };

  static const Map<String, String> ENGLISH_COLUMNS =
      const <String, String> {

    "User" : "User",
    "Issue": "Issue",
    "Hours" : "Hours",
    "Date": "Date",
    "Seperator": ","

  };



  static const List<Map<String, String>> AVAILABLE_LANGUAGE_COLUMNS =
  const <Map<String, String>>[GERMAN_COLUMNS, ENGLISH_COLUMNS];

  RedmineCsvLanguageAnalyzer(){}

  Map<String, String> getColumns(String csvText){

    Map<String, String> columns = new Map();

    int firstLineBreak = csvText.indexOf("\n");
    String firstTextLine = csvText.substring(0, firstLineBreak);

    final int languagesCount = AVAILABLE_LANGUAGE_COLUMNS.length;

    bool csvLanguageIsVerified;
    for(int iLanguage = 0; iLanguage < languagesCount; iLanguage++){

      final Map<String, String> currentLanguageColumns
        = AVAILABLE_LANGUAGE_COLUMNS[iLanguage];

      List<String> columnNames = new List.from(currentLanguageColumns.values);
      final int columnNamesCount = columnNames.length;

      bool allColumnsAreInCurrentLanguage;
      for(int iColumn = 0; iColumn < columnNamesCount; iColumn++){
        String currentColumnName = columnNames[iColumn];

        final bool firstLineContainsColumn
          = firstTextLine.contains(currentColumnName);

        if(firstLineContainsColumn){
          allColumnsAreInCurrentLanguage = true;
        } else {
          allColumnsAreInCurrentLanguage = false;
          break;
        }
      }

      if(allColumnsAreInCurrentLanguage){
        csvLanguageIsVerified = true;
        columns = currentLanguageColumns;
        break;
      }else{
        csvLanguageIsVerified = false;
      }
    }

    if(csvLanguageIsVerified){
      return columns;
    } else{
      throw new ArgumentError(
          '''Csv input does not have the needed columns.
           The csv input may has the wrong format
           or a not supported language (English, German).''');
    }
  }
}
