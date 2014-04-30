part of spend_time_visualizer;

class SpiderProportionVisualisation{

  static const String SPIDER_GRID_PROPORTION_VISUALISATION_PATH_CSS_CLASS = "spider_grid_proportion_visualisation_path";
  static const String SPIDER_GRID_PROPORTION_VISUALISATION_G_CSS_CLASS = "spider_grid_proportion_visualisation_g";

  final SpiderGrid _spiderGrid;
  final GElement spiderProportionVisualisationGElement;
  final PathElement spiderProportionVisualisationPathElement;

  num _radius;

  SpiderProportionVisualisation(this._radius, this._spiderGrid)
    : spiderProportionVisualisationPathElement = _initVisualisationPathElement()
      , spiderProportionVisualisationGElement = _initVisualisationGElement(){

    spiderProportionVisualisationGElement
    .append(spiderProportionVisualisationPathElement);
  }

  static PathElement _initVisualisationPathElement(){
    PathElement spiderProportionVisualisationPathElement = new PathElement();

    spiderProportionVisualisationPathElement
      .classes.add(SPIDER_GRID_PROPORTION_VISUALISATION_PATH_CSS_CLASS);

    return spiderProportionVisualisationPathElement;
  }

  static GElement _initVisualisationGElement(){

    GElement spiderProportionVisualisation = new GElement();
    spiderProportionVisualisation
      .classes.add(SPIDER_GRID_PROPORTION_VISUALISATION_G_CSS_CLASS);

    return spiderProportionVisualisation;
  }


  set proportionData(CaptionProportionPairCollection proportionData){

    var proportionDataMap = proportionData.nonExtendableObservableCaptionProportionPairsMap;
    final int dataCount = proportionDataMap.length;
    final bool isDataCountLowerThenThree = dataCount < 3;

    if(isDataCountLowerThenThree){
      throw new ArgumentError("Length of data collection must be greater than 2 to draw a spider chart.");
    }

    final Linear maxProportionToRadiusRemapper = new Linear();
    {
      final num maxProportion = proportionData.maxProportion;

      final List inputRange = [0, maxProportion];
      final List outputRange = [0, _radius];

      maxProportionToRadiusRemapper
        ..domain = inputRange
        ..range = outputRange;
    }


    final List<Coordinate> circleCoordiantes = new List();
    {
      for (int iData = 0; iData < dataCount; iData++ ) {
        Iterable<CaptionProportionPair> proportionDataValues = proportionDataMap.values;
        List proportionDataList = new List.from(proportionDataValues);

        CaptionProportionPair currentPair = proportionDataList[iData];
        final num currentProportion = currentPair.proportion;
        final String currentCaption = currentPair.caption;

        _spiderGrid.memberCaptionMap[currentCaption].text =
            "${currentCaption}: ${currentProportion}";

        final double proportionRadius = maxProportionToRadiusRemapper.scale(currentProportion);

        final double startRadian = DartMath.PI / dataCount;
        final Coordinate currentCoordiante = new CircleCoordinate(proportionRadius, iData, dataCount, startRadian);
        circleCoordiantes.add(currentCoordiante);
      }
    }

    _coordiantes = circleCoordiantes;
  }

  set _coordiantes(List<Coordinate> coordiantes){

    // clear old path coordinates
    PathSegList pathCoordinates = spiderProportionVisualisationPathElement.pathSegList;
    pathCoordinates.clear();

    // append startposition of the path
    {
      final Coordinate firstCoordiante = coordiantes.first;
      final num firstX = firstCoordiante.x;
      final num firstY = firstCoordiante.y;

      final PathSegMovetoAbs pathStartPosition = spiderProportionVisualisationPathElement.createSvgPathSegMovetoAbs(firstX, firstY);
      pathCoordinates.appendItem(pathStartPosition);
    }

    // append end of path
    {
      final int coordiantesCount = coordiantes.length;

      for(int iCoordinate = 1; iCoordinate < coordiantesCount; iCoordinate++){
        final Coordinate  currentCoordinate = coordiantes[iCoordinate];
        final num currentX = currentCoordinate.x;
        final num currentY = currentCoordinate.y;

        final PathSegLinetoAbs currentPathPosition = spiderProportionVisualisationPathElement.createSvgPathSegLinetoAbs(currentX, currentY);
        pathCoordinates.appendItem(currentPathPosition);
      }
    }

    // append end of path
    {
      PathSegClosePath closePath = spiderProportionVisualisationPathElement.createSvgPathSegClosePath();
      pathCoordinates.appendItem(closePath);
    }
  }
}