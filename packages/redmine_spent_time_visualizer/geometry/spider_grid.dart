part of spend_time_visualizer;

class SpiderGrid {

  static const String SPIDER_GRID_CAP_CSS = "spider_grid_cap";
  static const String SPIDER_GRID_AXIS_CSS = "spider_grid_axis";

  static const String SPIDER_GRID_AXIS_CAPTION_CSS = "spider_grid_axis_caption";
  static const String SPIDER_GRID_AXIS_CAPTION_LEFT_CSS = "spider_grid_axis_caption_left";
  static const String SPIDER_GRID_AXIS_CAPTION_RIGHT_CSS = "spider_grid_axis_caption_right";
  static const String SPIDER_GRID_AXIS_CAPTION_BOTTOM_CSS = "spider_grid_axis_caption_bottom";

  final GElement spiderGridGElement = new GElement();
  final GElement axisGElement = new GElement();
  final GElement axisLinesGElement = new GElement();
  final GElement axisTextsGElement = new GElement();


  SpiderGrid(){
    spiderGridGElement.append(axisGElement);
    axisGElement.append(axisLinesGElement);
    axisGElement.append(axisTextsGElement);
  }


  static List<List<Coordinate>> calculateGridCoordiantes(
      List<String> captionList,
      num capsCount, num radius) {
    List<List<Coordinate>> gridCoordiantes = new List();

    LinearScale gridLinearScale = createGridLinearScale(capsCount, radius);

    final int subdivisionAxisCount = captionList.length;
    double startRadian = DartMath.PI / subdivisionAxisCount;

    for (int iCap = 1; iCap <= capsCount; iCap++) {
      List<Coordinate> capCoordiantes = calculateCapCoordinates(
          gridLinearScale, iCap, subdivisionAxisCount, startRadian);
      gridCoordiantes.add(capCoordiantes);
    }

    return gridCoordiantes;
  }

  static List<Coordinate> calculateCapCoordinates(
      LinearScale gridLinearScale, int iCap, int subdivisionAxisCount,
      double startRadian) {
    List<Coordinate> capCoordiantes = new List();

    final double iCapRadius = gridLinearScale(iCap);

    for (int iAxis = 0; iAxis < subdivisionAxisCount; iAxis++) {
      final Coordinate capCoordiante = new CircleCoordinate(
          iCapRadius, iAxis, subdivisionAxisCount, startRadian);
      capCoordiantes.add(capCoordiante);
    }
    return capCoordiantes;
  }

  static LinearScale createGridLinearScale(num capsCount, num radius) =>
      linear()
        ..domain([0, capsCount])
        ..range([0, radius]);


  void draw(Map<String, num> data, int subdivisionCapsCount, num radius) {
    spiderGridGElement.children.clear();

    List<List<Coordinate>> gridCoordiantes = calculateGridCoordiantes(
        data.keys.toList(), subdivisionCapsCount, radius);

    drawCaps(gridCoordiantes);
    drawAxis(gridCoordiantes, data);
  }

  void drawAxis(List<List<Coordinate>> gridCoordinates, Map<String, num> data) {
    final int lastCapCoordinateList = gridCoordinates.length - 1;

    List<Coordinate> lastCap = gridCoordinates[lastCapCoordinateList];
    GElement axisGElement = createSpiderAxisGElement(lastCap, data);
    spiderGridGElement.append(axisGElement);
  }

  void drawCaps(List<List<Coordinate>> gridCoordiantes) {
    for (int iCap = 0; iCap < gridCoordiantes.length; iCap++) {
      List<Coordinate> capCoordinates = gridCoordiantes[iCap];
      PathElement capPathElement = createSpiderCapPathElement(
          capCoordinates);
      spiderGridGElement.append(capPathElement);
    }
  }

  PathElement createSpiderCapPathElement(List<Coordinate> capCoordiantes) {
    PathElement capSvgPath = new PathElement();
    capSvgPath.classes.add(SPIDER_GRID_CAP_CSS);

    LineFunction lineFunction = line()
      ..x(allowInterop(([LinePoint point, num index]) => point.x))
      ..y(allowInterop(([LinePoint point, num index]) => point.y))
      ..interpolate("linear-closed");

    var lineData = lineFunction.apply(lineFunction, [capCoordiantes]);

    capSvgPath.setAttribute("d", lineData);
    return capSvgPath;
  }

  GElement createSpiderAxisGElement(List<Coordinate> lastCapCoordiantes,
      Map<String, num> data) {
    final int axisCount = lastCapCoordiantes.length;
    axisLinesGElement.children.clear();
    axisTextsGElement.children.clear();

    for (int iAxis = 0; iAxis < axisCount; iAxis++) {
      Coordinate axisCoordinate = lastCapCoordiantes[iAxis];

      _appendAxisLineElement(axisLinesGElement, axisCoordinate);
      String axisLabelText = _lookUpAxisLabelText(data, iAxis);
      _appendAxisTextElement(axisTextsGElement, axisLabelText, axisCoordinate);
    }

    return axisGElement;
  }

  String _lookUpAxisLabelText(Map<String, num> data, int iAxis) {
    String keyForIndex = data.keys.toList()[iAxis];
    return "${keyForIndex}: ${data[keyForIndex]}";
  }

  void _appendAxisTextElement(GElement axisGElement, String axisLabelText,
      Coordinate currentAxis) {
    TextElement captionTextElement = new TextElement();
    captionTextElement.text = axisLabelText;
    axisGElement.append(captionTextElement);
    {
      final bool leftSideOfGraph = currentAxis.x < 0;
      final bool rightSideOfGraph = !leftSideOfGraph;
      final bool bottomSideOfGraph = currentAxis.y > 0;

      captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_CSS);

      if (leftSideOfGraph) {
        captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_LEFT_CSS);
      } else if (rightSideOfGraph) {
        captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_RIGHT_CSS);
      }

      if (bottomSideOfGraph) {
        captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_BOTTOM_CSS);
      }

      captionTextElement.attributes["x"] = currentAxis.x.toString();
      captionTextElement.attributes["y"] = currentAxis.y.toString();
    }
  }

  void _appendAxisLineElement(GElement axisGElement, Coordinate currentAxis) {
    LineElement axisLineElement = new LineElement();
    axisGElement.append(axisLineElement);
    {
      axisLineElement.attributes["x1"] = "0";
      axisLineElement.attributes["y1"] = "0";
      axisLineElement.attributes["x2"] = currentAxis.x.toString();
      axisLineElement.attributes["y2"] = currentAxis.y.toString();

      axisLineElement.classes.add(SPIDER_GRID_AXIS_CSS);
    }
  }
}
