@JS('d3')
library d3;

import 'package:js/js.dart';

@JS('scale.linear')
external LinearScale linear();

@JS()
class LinearScale{
  external dynamic domain([List<num> domain]);
  external dynamic range([List<num> range]);
}

external Dsv dsv(String delimiter, String type);

@JS()
class Dsv{
  external List<Object> parse(String stringToParse);
}

@JS('svg.line')
external LineFunction line();

@JS()
@anonymous
class LineFunction{
  external Function x(Function xFunction);
  external Function y(Function yFunction);
  external Function interpolate(String s);
  external dynamic apply([Object self, List<LinePoint> points]);


}

@JS()
@anonymous
class LinePoint {
  external num get x;
  external num get y;
  external factory LinePoint({num x, num y});
}

