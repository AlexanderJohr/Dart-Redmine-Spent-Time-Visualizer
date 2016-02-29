// Copyright (c) 2016, Alexander Johr. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:redmine_spent_time_visualizer/j_q_range_slider_interface.dart';
import 'package:redmine_spent_time_visualizer/spent_time_visualizer.dart';
import 'dart:async';
import 'package:js/js.dart';


main() async {
  Element spendTimeVisualizerElement = querySelector(
      '#spend_time_visualizer_container');

  SpiderChart spiderChart = new SpiderChart(5, 800, 800);
  spiderChart.renderTo(spendTimeVisualizerElement);

  String csvInput = await getExampleInput();
  RedmineData parsedExampleData = parseExampleData(csvInput);

  DateTime minDate = getMinDate(parsedExampleData);
  DateTime maxDate = getMaxDate(parsedExampleData).add(new Duration(days: 1));

  visualizeDataInSpiderChart(parsedExampleData, minDate, maxDate, spiderChart);

  createJQRangeSlider(minDate, maxDate, parsedExampleData, spiderChart);
}


Future<String> getExampleInput() async {
  String input = await HttpRequest.getString("./input/input.dsv");
  return input;
}

RedmineData parseExampleData(String input) {
  RedmineCsvParser redmineCsvParser = new RedmineCsvParser();
  RedmineData parsedData = redmineCsvParser.parse(input);
  return parsedData;
}

DateTime getMinDate(RedmineData parsedRedmineData) =>
    parsedRedmineData.timeSpendList.fold(
        parsedRedmineData.timeSpendList.first.date
    , (DateTime prev, RedmineSpentTime current) {
      bool currentIsMinDate = current.date.isBefore(prev);
      if (currentIsMinDate) return current.date;
      else return prev;
    });

DateTime getMaxDate(RedmineData parsedRedmineData) =>
    parsedRedmineData.timeSpendList.fold(
        parsedRedmineData.timeSpendList.first.date
    , (DateTime prev, RedmineSpentTime current) {
      bool currentIsMaxDate = current.date.isAfter(prev);
      if (currentIsMaxDate) return current.date;
      else return prev;
    });

void visualizeDataInSpiderChart(RedmineData parsedRedmineData, DateTime minDate,
    DateTime maxDate, SpiderChart spiderChart) {
  Map<String, num> hoursByMember = getHoursByMemberInTimePeriod(
      parsedRedmineData, minDate, maxDate);
  spiderChart.data = hoursByMember;
}

Map<String, num> getHoursByMemberInTimePeriod(RedmineData parsedRedmineData,
    DateTime minDate, DateTime maxDate) {
  Map<String, num> hoursByMemberInTimePeriod = new Map<String, num>();
  List<RedmineMember> members = parsedRedmineData.members;

  members.forEach((RedmineMember member) {
    List<RedmineSpentTime> spentTimeInPeriod = getSpentTimeInTimePeriod(
        member, minDate, maxDate);
    num sumOfHours = getSumOfHours(spentTimeInPeriod);

    hoursByMemberInTimePeriod.putIfAbsent(member.name, () => sumOfHours);
  });

  return hoursByMemberInTimePeriod;
}

List<RedmineSpentTime> getSpentTimeInTimePeriod(RedmineMember member,
    DateTime minDate, DateTime maxDate) =>

    member.timeSpendList.where((RedmineSpentTime spentTime) {
      return spentTime.date.isAfter(minDate) &&
          spentTime.date.isBefore(maxDate);
    });

num getSumOfHours(List<RedmineSpentTime> spentTimeInPeriod) =>
    spentTimeInPeriod.fold(
        0, (num sum, RedmineSpentTime spentTime) => sum + spentTime.hours);


void createJQRangeSlider(DateTime minDate, DateTime maxDate, RedmineData parsedExampleData, SpiderChart spiderChart) {

  var dateRangeSliderElement = jQuery('#date_section_range_slider');

  RangeSliderOptions rangeSliderOptions = new RangeSliderOptions(
      wheelMode: 'zoom',
      bounds: new RangeSliderDateRange(min: minDate, max: maxDate),
      defaultValues: new RangeSliderDateRange(min: minDate, max: maxDate));

  dateRangeSliderElement.dateRangeSlider(rangeSliderOptions);

  void dateSliderValuesChanging(e, ValueChangeEventData data) =>
      visualizeDataInSpiderChart(
          parsedExampleData, data.values.min, data.values.max, spiderChart);

  jQuery('#date_section_range_slider')
      .bind("valuesChanging", allowInterop(dateSliderValuesChanging));
}

