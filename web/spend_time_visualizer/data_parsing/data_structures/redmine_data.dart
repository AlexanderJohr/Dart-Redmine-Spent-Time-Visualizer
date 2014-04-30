part of spend_time_visualizer;

class RedmineData extends HasTimeSpendList{

  final Map<String, RedmineMember> redmineMemberMap;
  final Map<String, RedmineIssue> redmineIssueMap;

  final DateTime minDate, maxDate;

  RedmineData(this.redmineMemberMap
      , this.redmineIssueMap, List<RedmineTimeSpend> redmineTimeSpendList)
      : super(redmineTimeSpendList)
      , minDate = initMinDate(redmineTimeSpendList)
      , maxDate = initMaxDate(redmineTimeSpendList){

    sortAllSpendTimeLists();
  }

  void sortAllSpendTimeLists(){
    // Sort time spend lists of the members
    {
      final List<RedmineMember> redmineMemberList =
          new List.from(redmineMemberMap.values);

      final int redmineMemberListLength = redmineMemberList.length;

      for(int iMember = 0; iMember < redmineMemberListLength; iMember++){
        RedmineMember  currentMember = redmineMemberList[iMember];
        currentMember.sortTimeSpendList();
      }
    }

    // Sort time spend lists of the issues
    {
      final List<RedmineIssue> redmineIssueList =
          new List.from(redmineIssueMap.values);

      final int redmineIssueListLength = redmineIssueList.length;

      for(int iIssue = 0; iIssue < redmineIssueListLength; iIssue++){
        RedmineIssue   currentIssue = redmineIssueList[iIssue];
        currentIssue.sortTimeSpendList();
      }
    }

  }

  static DateTime initMinDate(List<RedmineTimeSpend> redmineTimeSpendList) {
    RedmineTimeSpend firstTimeSpend = redmineTimeSpendList.first;
    DateTime  firstTimeSpendDate = firstTimeSpend.date;
    return firstTimeSpendDate;
  }

  static DateTime initMaxDate(List<RedmineTimeSpend> redmineTimeSpendList) {
    RedmineTimeSpend lastTimeSpend = redmineTimeSpendList.last;
    DateTime  lastTimeSpendDate = lastTimeSpend.date;
    return lastTimeSpendDate;
  }







}