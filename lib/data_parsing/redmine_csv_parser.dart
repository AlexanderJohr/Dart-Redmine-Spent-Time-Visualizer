part of spend_time_visualizer;

class RedmineCsvParser {

  RedmineData parse(final String csvText) {
    Map<String, RedmineMember> memberMap = new Map<String, RedmineMember>();
    Map<String, RedmineIssue> issueMap = new Map<String, RedmineIssue>();
    List<RedmineSpentTime> timeSpendList = new List<RedmineSpentTime>();

    var redmineCsvLanguageAnalyzer = new RedmineCsvLanguageAnalyzer();
    Map<String, String> columnNameMap = redmineCsvLanguageAnalyzer.getColumns(
        csvText);

    final String userColumnName = columnNameMap['User'];
    final String issueColumnName = columnNameMap['Issue'];
    final String dateColumnName = columnNameMap['Date'];
    final String hoursColumnName = columnNameMap['Hours'];

    final String separator = columnNameMap['Seperator'];

    final Dsv semicolonSeparatedValueParser = dsv(separator, "text/csv");

    List<Object> parsedCsv
    = semicolonSeparatedValueParser.parse(csvText);

    int rowsLength = parsedCsv.length;

    final bool hoursFormatHasToChangeFromCommaToPoint =
        hoursColumnName == "Stunden";

    for (int iRow = 0; iRow < rowsLength; iRow++) {
      CsvDataRow row = parsedCsv[iRow];


      RedmineMember member = parseMember(row, userColumnName, memberMap);
      RedmineIssue issue = parseIssue(
          row, issueColumnName, issueMap, member);

      DateTime date = parseDate(row, dateColumnName);
      num hours = parseHours(
          row, hoursColumnName, hoursFormatHasToChangeFromCommaToPoint);

      parseSpentTime(member, issue, hours, date, timeSpendList);
    }

    RedmineData redmineData =
    new RedmineData(
        memberMap.values, issueMap.values, timeSpendList);

    return redmineData;
  }

  RedmineSpentTime parseSpentTime(RedmineMember member, RedmineIssue issue,
      num hours, DateTime date,
      List<RedmineSpentTime> timeSpendList) {
    RedmineSpentTime currentSpentTime = new RedmineSpentTime(
        member, issue, hours, date);
    member.timeSpendList.add(currentSpentTime);
    issue.timeSpendList.add(currentSpentTime);
    timeSpendList.add(currentSpentTime);

    return currentSpentTime;
  }

  num parseHours(CsvDataRow currentRow, String hoursColumnName,
      bool hoursFormatHasToChangeFromCommaToPoint) {
    String currentHoursString = currentRow.Hours;
    if (hoursFormatHasToChangeFromCommaToPoint) {
      currentHoursString = currentHoursString.replaceAll(",", ".");
    }
    num currentHours = num.parse(currentHoursString);
    return currentHours;
  }

  DateTime parseDate(CsvDataRow currentRow, String dateColumnName) {
    String currentDateString = currentRow.Date;
    DateTime currentDate = DateTime.parse(currentDateString);
    return currentDate;
  }

  RedmineIssue parseIssue(CsvDataRow currentRow,
      String issueColumnName, Map<String, RedmineIssue> issueMap,
      RedmineMember member) {
    String issueName = currentRow.Issue;
    RedmineIssue issue = issueMap.putIfAbsent(issueName, () {
      RedmineIssue newIssue = new RedmineIssue(member, issueName);
      member.ticketList.add(newIssue);
      return newIssue;
    });
    return issue;
  }

  RedmineMember parseMember(CsvDataRow currentRow,
      String userColumnName, Map<String, RedmineMember> memberMap) {

    String currentMemberName = currentRow.User;

    RedmineMember member = memberMap.putIfAbsent(
        currentMemberName, () => new RedmineMember(currentMemberName));
    return member;
  }

}
