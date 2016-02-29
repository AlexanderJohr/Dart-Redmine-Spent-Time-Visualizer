part of spend_time_visualizer;

class Coordinate{

  num _x,_y;

  Coordinate([this._x, this._y]){}

  num get y => _y;
  num get x => _x;

  toString() => "x: $x; y: $y";

}