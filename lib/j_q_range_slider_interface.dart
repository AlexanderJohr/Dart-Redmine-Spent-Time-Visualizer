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
class Date {
  external Date([int year, int month, int day]);
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
@anonymous
class RangeSliderDateRange {
  external get wheelMode;

  external DateTime get min;

  external DateTime get max;

  external factory RangeSliderDateRange({DateTime min, DateTime max});
}

@JS()
@anonymous
class ValueChangeEventData {
  external ValueChangeEventDataValues get values;

}

@JS()
@anonymous
class ValueChangeEventDataValues {
  external DateTime get min;
  external DateTime get max;
}


