// Copyright (c) 2016, Alexander Johr. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:js/js.dart';
import 'package:redmine_spent_time_visualizer/spent_time_visualizer.dart';

SpiderChart spiderChart = new SpiderChart(
    subdivisionCapsCount: 5,
    width: 1000,
    height: 1000,
    padding: new Padding(200,200,50,50));



main() async {
  Element spendTimeVisualizerElement = querySelector(
      '#spent_time_visualizer_container');
  spiderChart.renderTarget = spendTimeVisualizerElement;

  TextAreaElement importCsvInput = querySelector(
      "#import_csv_input") as TextAreaElement;
  String textAreaCsvInput = await getTextAreaInput();
  importCsvInput.value = textAreaCsvInput;


  String csvInput = await getExampleInput();
  handleCsvInput(csvInput);

  Element calculateButton = querySelector("#calculate_button");
  calculateButton.onClick.listen((MouseEvent event) {
    String csvInput = importCsvInput.value;
    handleCsvInput(csvInput);
  });
}

void handleCsvInput(String csvInput) {
  RedmineData parsedExampleData = parseExampleData(csvInput);

  DateTime minDate = getMinDate(parsedExampleData);
  DateTime maxDate = getMaxDate(parsedExampleData).add(new Duration(days: 1));
  visualizeDataInSpiderChart(parsedExampleData, minDate, maxDate, spiderChart);
  createJQRangeSlider(minDate, maxDate, parsedExampleData, spiderChart);
}

Future<String> getExampleInput() async =>
    await HttpRequest.getString("./input/input.dsv");

Future<String> getTextAreaInput() async =>
    await HttpRequest.getString("./input/text_area_input.dsv");


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


void createJQRangeSlider(DateTime minDate, DateTime maxDate,
    RedmineData parsedExampleData, SpiderChart spiderChart) {
  var dateRangeSliderElement = jQuery('#date_section_range_slider');

  Date jsMinDate = new Date(minDate.year, minDate.month, minDate.day);
  Date jsMaxDate = new Date(maxDate.year, maxDate.month, maxDate.day);

  RangeSliderOptions rangeSliderOptions = new RangeSliderOptions(
      wheelMode: 'zoom',
      bounds: new RangeSliderDateRange(min: jsMinDate, max: jsMaxDate),
      defaultValues: new RangeSliderDateRange(min: jsMinDate, max: jsMaxDate));

  dateRangeSliderElement.dateRangeSlider(rangeSliderOptions);


  void dateSliderValuesChanging(e, ValueChangeEventData data) {
    DateTime minDate =
    new DateTime.fromMillisecondsSinceEpoch(data.values.min.getTime());
    DateTime maxDate =
    new DateTime.fromMillisecondsSinceEpoch(data.values.max.getTime());

    visualizeDataInSpiderChart(
        parsedExampleData, minDate, maxDate, spiderChart);
  }

  jQuery('#date_section_range_slider')
      .bind("valuesChanging", allowInterop(dateSliderValuesChanging));
}
