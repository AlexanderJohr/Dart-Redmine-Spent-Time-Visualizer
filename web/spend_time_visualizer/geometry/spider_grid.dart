part of spend_time_visualizer;

class SpiderGrid{

  static const String SPIDER_GRID_CAP_CSS = "spider_grid_cap";
  static const String SPIDER_GRID_AXIS_CSS = "spider_grid_axis";

  static const String SPIDER_GRID_AXIS_CAPTION_CSS = "spider_grid_axis_caption";
  static const String SPIDER_GRID_AXIS_CAPTION_LEFT_CSS = "spider_grid_axis_caption_left";
  static const String SPIDER_GRID_AXIS_CAPTION_RIGHT_CSS = "spider_grid_axis_caption_right";
  static const String SPIDER_GRID_AXIS_CAPTION_BOTTOM_CSS = "spider_grid_axis_caption_bottom";

  final Map<String, TextElement> memberCaptionMap = new Map();
  final List<List<Coordinate>> _gridCoordiantes;
  final List<String> _captionList;

  SpiderGrid(List<String> captionList, int subdivisionCapsCount, num radius)
      : _captionList = captionList
      , _gridCoordiantes = initGridCoordiantes(captionList, subdivisionCapsCount, radius)
  {


  }

  static List<List<Coordinate>> initGridCoordiantes(
      List<String> captionList, int capsCount, num radius){

    List<List<Coordinate>> gridCoordiantes = new List();

    List inputRange = [0, capsCount];
    List outputRange = [0, radius];

    final Linear capsCountToRadiusRemapper = new Linear();
    capsCountToRadiusRemapper
      ..domain = inputRange
      ..range = outputRange;

    final int subdivisionAxisCount = captionList.length;

    double startRadian = DartMath.PI / subdivisionAxisCount;

    for (int iCap = 1; iCap <= capsCount; iCap++ ) {

      List<Coordinate> capCoordiantes = new List();

      final double iCapRadius = capsCountToRadiusRemapper.scale(iCap);

      for (int iAxis = 0; iAxis < subdivisionAxisCount; iAxis++ ) {
        final Coordinate capCoordiante = new CircleCoordinate(iCapRadius, iAxis, subdivisionAxisCount, startRadian);
        capCoordiantes.add(capCoordiante);
      }

      gridCoordiantes.add(capCoordiantes);
    }

    return gridCoordiantes;
  }

  GElement get spiderGridGElement{

    final int capsCount = _gridCoordiantes.length;

    final int lastCapCoordinateList = capsCount - 1;

    GElement spiderGridGElement = new GElement();
    for (int iCap = 0; iCap <= lastCapCoordinateList; iCap++ ) {

      List<Coordinate> currentCapCoordiantes = _gridCoordiantes[iCap];
      PathElement capPathElement = getSpiderCapPathElement(currentCapCoordiantes);

      spiderGridGElement.append(capPathElement);
    }

    // generate Axis
    {
      List<Coordinate> lastCapCoordiantes = _gridCoordiantes[lastCapCoordinateList];
      GElement axisGElement = getSpiderAxisGElement(lastCapCoordiantes, _captionList);
      spiderGridGElement.append(axisGElement);
    }

    return spiderGridGElement;
  }

  PathElement getSpiderCapPathElement(List<Coordinate> capCoordiantes){
    final int axisCount = capCoordiantes.length;

    PathElement capSvgPath = new PathElement();
    capSvgPath.classes.add(SPIDER_GRID_CAP_CSS);

    PathSegList pathSegList = capSvgPath.pathSegList;
    Coordinate firstAxisInCurrentCap = capCoordiantes[0];

    pathSegList.appendItem(capSvgPath.createSvgPathSegMovetoAbs(firstAxisInCurrentCap.x, firstAxisInCurrentCap.y));

    for (int iAxis = 1; iAxis < axisCount; iAxis++ ) {
      Coordinate  currentAxis = capCoordiantes[iAxis];
      pathSegList.appendItem(capSvgPath.createSvgPathSegLinetoAbs(currentAxis.x, currentAxis.y));
    }

    pathSegList.appendItem(capSvgPath.createSvgPathSegClosePath());

    return capSvgPath;
  }

  GElement getSpiderAxisGElement(List<Coordinate> lastCapCoordiantes, List<String> _captionList){

    final int axisCount = lastCapCoordiantes.length;

    final GElement axisGElement = new GElement();
    for (int iAxis = 0; iAxis < axisCount; iAxis++ ) {
      LineElement axisLineElement = new LineElement();
      TextElement captionTextElement = new TextElement();


      {
        axisGElement.append(axisLineElement);
        axisGElement.append(captionTextElement);
        {
          Coordinate  currentAxis = lastCapCoordiantes[iAxis];
          String  currentCaption = _captionList[iAxis];
          captionTextElement.text = currentCaption;
          memberCaptionMap[currentCaption] = captionTextElement;

          final String currentX = currentAxis.x.toString();
          final String  currentY = currentAxis.y.toString();

          final bool leftSideOfGraph = currentAxis.x < 0;
          final bool rightSideOfGraph = !leftSideOfGraph;
          final bool bottomSideOfGraph  = currentAxis.y > 0;

          captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_CSS);

          if(leftSideOfGraph){
            captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_LEFT_CSS);
          } else if(rightSideOfGraph){
            captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_RIGHT_CSS);
          }

          if(bottomSideOfGraph){
            captionTextElement.classes.add(SPIDER_GRID_AXIS_CAPTION_BOTTOM_CSS);
          }

          captionTextElement.attributes["x"] = currentX;
          captionTextElement.attributes["y"] = currentY;

          axisLineElement.attributes["x1"] = "0";
          axisLineElement.attributes["y1"] = "0";
          axisLineElement.attributes["x2"] = currentX;
          axisLineElement.attributes["y2"] = currentY;

          axisLineElement.classes.add(SPIDER_GRID_AXIS_CSS);
        }
      }
    }

    return axisGElement;
  }


}
