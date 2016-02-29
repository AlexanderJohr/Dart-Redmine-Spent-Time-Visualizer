library jquery;

import 'package:js/js.dart';

@JS('jQuery')
external QueryResult jQuery(String query);

@JS()
class QueryResult {
  external dynamic dateRangeSlider([RangeSliderOptions rangeSliderOptions]);

  external dynamic bind([String event, Function callback]);
}

@JS()
external printOptions(Options options);

@JS()
@anonymous
class Options {
  external bool get responsive;

  external factory Options({bool responsive});
}

@JS()
@anonymous
class RangeSliderOptions {
  external String get wheelMode;

  external RangeSliderDateRange get bounds;

  external RangeSliderDateRange get defaultValues;

  external factory RangeSliderOptions({String wheelMode
  , RangeSliderDateRange bounds
  , RangeSliderDateRange defaultValues});
}

@JS()
class Date {
  external num getTime();
  external factory Date([int year, int month, int day]);
}

@JS()
@anonymous
class RangeSliderDateRange {
  external get wheelMode;

  external Date get min;

  external Date get max;

  external factory RangeSliderDateRange({Date min, Date max});
}

@JS()
@anonymous
class ValueChangeEventData {
  external ValueChangeEventDataValues get values;

}

@JS()
@anonymous
class ValueChangeEventDataValues {
  external Date get min;
  external Date get max;
}


