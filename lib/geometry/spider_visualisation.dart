part of spend_time_visualizer;

class SpiderVisualisation {

  static const String SPIDER_GRID_VISUALISATION_PATH_CSS_CLASS = "spider_grid_proportion_visualisation_path";
  static const String SPIDER_GRID_PROPORTION_VISUALISATION_G_CSS_CLASS = "spider_grid_proportion_visualisation_g";

  final num _radius;
  final SpiderGrid _spiderGrid;
  final GElement gElement = new GElement();
  final PathElement pathElement = new PathElement();


  SpiderVisualisation(this._spiderGrid, this._radius) {
    _initGElement();
    _initPathElement();
  }

  void _initPathElement() {
    pathElement.classes.add(SPIDER_GRID_VISUALISATION_PATH_CSS_CLASS);
    gElement.append(pathElement);
  }

  void _initGElement() {
    gElement.classes.add(SPIDER_GRID_PROPORTION_VISUALISATION_G_CSS_CLASS);
  }

  static d3.LinearScale _createLinearScale(Iterable<num> data, num radius) {
    final d3.LinearScale linearScale = d3.linear();

    num maxValue = data.fold(
        0, (num prevMax, currData) => DartMath.max(prevMax, currData));

    return linearScale
      ..domain([0, maxValue])
      ..range([0, radius]);
  }

  set data(Map<String, num> dataByCaption) {
    final bool isDataCountLowerThenThree = dataByCaption.length < 3;

    if (isDataCountLowerThenThree) {
      throw new ArgumentError(
          "Length of data collection must be greater than 2 to draw a spider chart.");
    }

    d3.LinearScale linearScale = _createLinearScale(
        dataByCaption.values, _radius);
    List<Coordinate> circleCoordinates = _calculateCircleCoordinates(
        linearScale, dataByCaption.values);

    _drawPath(circleCoordinates);
  }

  List<Coordinate> _calculateCircleCoordinates(d3.LinearScale linearScale,
      Iterable<num> data) {
    final List<Coordinate> circleCoordinates = new List();
    final num subdivisionCount = data.length;
    final double startRadian = DartMath.PI / subdivisionCount;

    num subdivisionAxisIndex = 0;
    data.forEach((num value) {
      final num radius = linearScale(value);

      final Coordinate circleCoordinate = new CircleCoordinate(
          radius, subdivisionAxisIndex, subdivisionCount, startRadian);
      circleCoordinates.add(circleCoordinate);

      subdivisionAxisIndex++;
    });

    return circleCoordinates;
  }

  void _drawPath(List<Coordinate> coordinates) {
    d3.LineFunction lineFunction = d3.line()
      ..x(allowInterop(([LinePoint point, num index]) => point.x))
      ..y(allowInterop(([LinePoint point, num index]) => point.y))
      ..interpolate("linear-closed");

    var lineData = lineFunction.apply(lineFunction, [coordinates]);

    pathElement.setAttribute("d", lineData);
  }
}
