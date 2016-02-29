part of spend_time_visualizer;

class RedmineData extends HasTimeSpendList{

  final List<RedmineMember> members;
  final List<RedmineIssue> issues;

  RedmineData(this.members, this.issues, List<RedmineSpentTime> spentTime)
      : super(spentTime);
}