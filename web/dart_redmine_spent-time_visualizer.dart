import 'dart:html';
import 'spend_time_visualizer/spend_time_visualizer.dart';
import 'dart:svg';



import 'package:js/js.dart' as js;

Element spendTimeVisualizerElement = querySelector('#spend_time_visualizer_chart');
SpiderChart spiderChart;

void main() {

  Element calculateButton = querySelector("#calculate_button");
  calculateButton.onClick.listen(onData);

  generateOutput();
}

void calculateSpendTime(String csvText) {
  List<CaptionProportionPair> pairs = new List();

  RedmineCsvParser redmineCsvParser = new RedmineCsvParser();
  RedmineData parsedRedmineData = redmineCsvParser.parse(csvText);

  DateTime maxDate = parsedRedmineData.maxDate.add(new Duration(days: 1));
  DateTime minDate = parsedRedmineData.minDate;

  Map<String, RedmineMember> redmineMemberMap = parsedRedmineData.redmineMemberMap;
  List<String> mebmerKeyList = new List.from(redmineMemberMap.keys);
  int mebmerKeyListLength = mebmerKeyList.length;

  for (int iMemberKey = 0; iMemberKey < mebmerKeyListLength; iMemberKey++) {

    String currentMemberkey = mebmerKeyList[iMemberKey];
    CaptionProportionPair currentCaptionProportionPair = new CaptionProportionPair(currentMemberkey, 0.0);
    pairs.add(currentCaptionProportionPair);

  }

  CaptionProportionPairCollection captionProportionPairCollection = new CaptionProportionPairCollection(pairs);

  spiderChart = new SpiderChart(captionProportionPairCollection, 5, 800, 800);
  GElement spiderChartGElement = spiderChart.spiderChartGElement;
  spendTimeVisualizerElement.children.clear();
  spendTimeVisualizerElement.append(spiderChartGElement);

  Map<String, CaptionProportionPair> observableMap = captionProportionPairCollection.nonExtendableObservableCaptionProportionPairsMap;

  void calculateChartData(DateTime firstDate, DateTime lastDate) {

    for (int iMemberKey = 0; iMemberKey < mebmerKeyListLength; iMemberKey++) {

      final String currentMemberkey = mebmerKeyList[iMemberKey];
      final RedmineMember currentMember = redmineMemberMap[currentMemberkey];

      final num currentMemberHours = currentMember.getHoursBetweenTwoDates(firstDate, lastDate);

      CaptionProportionPair captionProportionPair = observableMap[currentMemberkey];
      captionProportionPair.proportion = currentMemberHours;

    }
  }

  // Build the date range slider
  js.context.$("#date_section_range_slider").dateRangeSlider(js.map({

    'wheelMode': "zoom",
    'bounds': js.map({
      'min': new js.Proxy(js.context.Date, minDate.year, minDate.month - 1, minDate.day),
      'max': new js.Proxy(js.context.Date, maxDate.year, maxDate.month - 1, maxDate.day)
    }),

    'defaultValues': js.map({
      'min': new js.Proxy(js.context.Date, minDate.year, minDate.month - 1, minDate.day),
      'max': new js.Proxy(js.context.Date, maxDate.year, maxDate.month - 1, maxDate.day)
    })
  }));

  void dateSliderValuesChanging(e, data) {

    ElementList<DivElement> dateDivs = querySelectorAll(".ui-rangeSlider-label-value");

    final DivElement firstDiv = dateDivs[0];
    final String firstDivText = firstDiv.text;
    final DateTime firstDivDate = DateTime.parse(firstDivText);

    final DivElement secondDiv = dateDivs[1];
    final String secondDivText = secondDiv.text;
    final DateTime secondDivDate = DateTime.parse(secondDivText);

    DateTime firstDate;
    DateTime lastDate;
    if (firstDivDate.isBefore(secondDivDate)) {
      firstDate = firstDivDate;
      lastDate = secondDivDate;
    } else {
      firstDate = secondDivDate;
      lastDate = firstDivDate;
    }

    calculateChartData(firstDate, lastDate);
  }
  ;

  js.context.$("#date_section_range_slider")
      ..unbind("valuesChanging")
      ..bind("valuesChanging", dateSliderValuesChanging);


  // calculate the data the first time.
  calculateChartData(minDate, maxDate);






}


void onData(MouseEvent event) {
  generateOutput();
}

void generateOutput() {
  TextAreaElement importCsvInput = querySelector("#import_csv_input") as TextAreaElement;
  String text = importCsvInput.value;
  calculateSpendTime(text);
}
