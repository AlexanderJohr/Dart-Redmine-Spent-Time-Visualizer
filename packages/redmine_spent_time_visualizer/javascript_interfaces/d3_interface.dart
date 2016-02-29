part of spend_time_visualizer;

@JS('d3.scale.linear')
external LinearScale linear();

@JS()
class LinearScale{
  external dynamic domain([List<num> domain]);
  external dynamic range([List<num> range]);
}

@JS('d3.dsv')
external Dsv dsv(String delimiter, String type);

@JS()
class Dsv{
  external List<Object> parse(String stringToParse);
}

@JS('d3.svg.line')
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

