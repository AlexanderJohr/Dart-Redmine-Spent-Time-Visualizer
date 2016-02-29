part of spend_time_visualizer;

class SpiderChart {

  SpiderVisualisation _spiderVisualisation;
  SpiderGrid _spiderGrid = new SpiderGrid();
  GElement spiderChartGElement = new GElement();

  int _subdivisionCapsCount;
  num _width, _height;
  Map<String, num> _data;
  Element _renderTarget;
  Padding _padding;

  num get width => _width;

  set width(num value) => _width = value;

  num get height => _height;

  set height(num value) => _height = value;

  int get subdivisionCapsCount => _subdivisionCapsCount;

  set subdivisionCapsCount(int value) => _subdivisionCapsCount = value;

  Padding get padding => _padding;

  set padding(Padding value) => _padding = value;

  Element get renderTarget => _renderTarget;

  set renderTarget(Element target) {
    _renderTarget = target;
    target.append(spiderChartGElement);
  }

  SpiderChart(
      {int subdivisionCapsCount: 5, num width: 400, num height: 400, Padding padding})
      : _subdivisionCapsCount = subdivisionCapsCount,
        _width = width,
        _height = height,
        _padding = padding {
    _appendGrid();
    _appendVisualisation();
  }

  void _appendVisualisation() {
    _spiderVisualisation = new SpiderVisualisation(_spiderGrid, _radius);
    GElement spiderVisualisationGElement = _spiderVisualisation
        .gElement;
    spiderChartGElement.append(spiderVisualisationGElement);
  }

  void _appendGrid() {
    GElement spiderGridGElement = _spiderGrid.spiderGridGElement;
    spiderChartGElement.append(spiderGridGElement);
  }


  set data(Map<String, num> data) {
    this._data = data;
    this.draw();
  }

  void draw() {
    _spiderGrid.draw(_data, _subdivisionCapsCount, _radius);
    _spiderVisualisation.draw(_data);
    _transformChartToFitBounds();
  }

  num get _radius => DartMath.min(width, height) / 2;

  void _transformChartToFitBounds() {
    Rect bbox = _spiderGrid.axisLinesGElement.getBBox();
    _renderTarget.attributes["viewBox"] =
    "${bbox.x - _padding.left} ${bbox.y - _padding.top} ${bbox.width +
        _padding.right + _padding.left} ${bbox.height + padding.bottom + _padding.top }";

  }
}
