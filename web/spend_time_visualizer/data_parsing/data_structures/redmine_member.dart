part of spend_time_visualizer;

class RedmineMember extends HasTimeSpendList{
  final String name;
  final List<RedmineIssue> ticketList = new List();

  RedmineMember(this.name): super(new List());
}