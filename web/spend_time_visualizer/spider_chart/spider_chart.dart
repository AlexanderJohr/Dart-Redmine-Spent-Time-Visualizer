part of spend_time_visualizer;

class SpiderChart implements Observer<CaptionProportionPair>{

  SpiderProportionVisualisation _spiderProportionVisualisation;
  CaptionProportionPairCollection _captionProportionPair;
  int _subdivisionCapsCount;
  num _width, _height;

  num get width => _width;
      set width (num value) => _width = value;

  num get height => _height;
      set height (num value) => _height = value;

  int get subdivisionCapsCount => _subdivisionCapsCount;
      set subdivisionCapsCount (int value) => _subdivisionCapsCount = value;


  CaptionProportionPairCollection get captionProportionPair => _captionProportionPair;


  SpiderChart(this._captionProportionPair, this._subdivisionCapsCount, this._width, this._height){
    _captionProportionPair.addObserver(this);


  }

  GElement get spiderChartGElement{

    GElement spiderChartGElement = new GElement();

    final num chartInnerSquare = DartMath.min(width, height);
    final num halfChartInnerSquare = chartInnerSquare / 2;
    final num radius = halfChartInnerSquare;

    {
      final num halfWidth = width / 2;
      final num halfHeight = height / 2;

      spiderChartGElement.attributes["transform"] = "translate(${halfWidth},${halfHeight})";
    }

    Map<String, CaptionProportionPair> pairs =
        captionProportionPair.nonExtendableObservableCaptionProportionPairsMap;
    List captionList = new List.from(pairs.keys);


    {
      SpiderGrid spiderGrid =
          new SpiderGrid(captionList, subdivisionCapsCount, radius);
      GElement spiderGridGElement = spiderGrid.spiderGridGElement;
      spiderChartGElement.append(spiderGridGElement);

      _spiderProportionVisualisation = new SpiderProportionVisualisation(radius, spiderGrid);
      GElement spiderProportionVisualisationGElement = _spiderProportionVisualisation.spiderProportionVisualisationGElement;
      spiderChartGElement.append(spiderProportionVisualisationGElement);
      _spiderProportionVisualisation.proportionData = _captionProportionPair;
    }


    return spiderChartGElement;

  }

  void update(Observable<CaptionProportionPair> observable
              , CaptionProportionPair argument) {

    _spiderProportionVisualisation.proportionData =
        _captionProportionPair;

  }
}
