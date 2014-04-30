part of spend_time_visualizer;

class RedmineTimeSpend{
  final DateTime date;
  final RedmineMember member;
  final RedmineIssue ticket;
  final String description;
  final num hours;

  RedmineTimeSpend(this.member, this.ticket
      , this.hours, this.date, { this.description : ""}){}
}