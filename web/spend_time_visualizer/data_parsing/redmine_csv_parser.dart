part of spend_time_visualizer;

class RedmineCsvParser{

  RedmineData parse(final String csvText){

    Map<String, RedmineMember> redmineMemberMap = new Map();
    Map<String, RedmineIssue> redmineIssueMap = new Map();
    List<RedmineTimeSpend> redmineTimeSpendList = new List();

    var redmineCsvLanguageAnalyzer = new RedmineCsvLanguageAnalyzer();
    Map<String, String> columnNameMap = redmineCsvLanguageAnalyzer.getColumns(csvText);

    String userColumnName = columnNameMap['User'];
    String issueColumnName = columnNameMap['Issue'];
    String dateColumnName = columnNameMap['Date'];
    String hoursColumnName = columnNameMap['Hours'];

    final String seperator = columnNameMap['Seperator'];

    final DSV semicolonSeparatedValueParser = new DSV(seperator, "text/csv");

    List<Map<String, Object>> parsedCsv
      = semicolonSeparatedValueParser.parse(csvText);

    int rowsLength = parsedCsv.length;

    final bool hoursFormatHasToChangeFromCommaToPoint =
        hoursColumnName == "Stunden";

    for(int iRow = 0; iRow < rowsLength; iRow++){

      Map<String, String> currentRow = parsedCsv[iRow];

      String currentMemberName = currentRow[userColumnName];
      RedmineMember currentMember = _getOrCreateMember(redmineMemberMap
          , currentMemberName);

      String currentIssueTitle = currentRow[issueColumnName];
      RedmineIssue currentIssue = _getOrCreateIssue(redmineIssueMap,
          currentIssueTitle, currentMember);

      String currentDateString = currentRow[dateColumnName];
      DateTime currentDate = DateTime.parse(currentDateString);

      String currentHoursString = currentRow[hoursColumnName];
      if(hoursFormatHasToChangeFromCommaToPoint){
        currentHoursString = currentHoursString.replaceAll(",", ".");
      }
      num currentHours = num.parse(currentHoursString);


      RedmineTimeSpend currentTimeSpend =
          new RedmineTimeSpend(currentMember, currentIssue, currentHours, currentDate);
      currentMember.timeSpendList.add(currentTimeSpend);
      currentIssue.timeSpendList.add(currentTimeSpend);
      redmineTimeSpendList.add(currentTimeSpend);
    }



    RedmineData redmineData =
        new RedmineData(redmineMemberMap, redmineIssueMap, redmineTimeSpendList);



    return redmineData;
  }

  static RedmineMember _getOrCreateMember(Map<String, RedmineMember> redmineMemberMap
                                  , String userName){

    final bool memberAlreadyCreated = redmineMemberMap.containsKey(userName);

    if(memberAlreadyCreated){
      final RedmineMember foundMember = redmineMemberMap[userName];
      return foundMember;
    } else {
      RedmineMember newRedmineMember = new RedmineMember(userName);
      redmineMemberMap[userName] = newRedmineMember;
      return newRedmineMember;
    }
  }

  static RedmineIssue _getOrCreateIssue(
    Map<String, RedmineIssue> redmineIssueMap
    , String issueName, RedmineMember owningMember){

    final bool issueAlreadyCreated =
        redmineIssueMap.containsKey(issueName);

    if(issueAlreadyCreated){
      final RedmineIssue foundIssue =
          redmineIssueMap[issueName];
      return foundIssue;
    } else {
      RedmineIssue newRedmineIssue =
          new RedmineIssue(owningMember, issueName);
      owningMember.ticketList.add(newRedmineIssue);
      redmineIssueMap[issueName] = newRedmineIssue;
      return newRedmineIssue;
    }

  }



}
