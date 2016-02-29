part of spend_time_visualizer;

class SpiderChart {

  SpiderVisualisation _spiderVisualisation;
  SpiderGrid _spiderGrid = new SpiderGrid();
  GElement spiderChartGElement = new GElement();

  int _subdivisionCapsCount;
  num _width, _height;

  num get width => _width;

  set width(num value) => _width = value;

  num get height => _height;

  set height(num value) => _height = value;

  int get subdivisionCapsCount => _subdivisionCapsCount;

  set subdivisionCapsCount(int value) => _subdivisionCapsCount = value;

  SpiderChart(this._subdivisionCapsCount, this._width, this._height) {
    _appendGrid();
    _appendVisualisation();
    _transformChartToFitBounds();
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

  void renderTo(Element target) {
    target.append(spiderChartGElement);
  }

  set data(Map<String, num> data) {
    _spiderGrid.draw(data, subdivisionCapsCount, _radius);
    _spiderVisualisation.data = data;
  }

  num get _radius => DartMath.min(width, height) / 2;

  void _transformChartToFitBounds() {
    final num halfWidth = width / 2;
    final num halfHeight = height / 2;
    spiderChartGElement.attributes["transform"] =
    "translate(${halfWidth},${halfHeight})";
  }
}
