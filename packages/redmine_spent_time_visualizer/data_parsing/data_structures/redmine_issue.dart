part of spend_time_visualizer;

class RedmineIssue extends HasTimeSpendList{
  final String title;
  final RedmineMember member;


  RedmineIssue(this.member, this.title)
    : super(new List());
}