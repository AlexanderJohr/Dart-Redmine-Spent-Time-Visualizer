part of spend_time_visualizer;

class CircleCoordinate extends Coordinate{

  CircleCoordinate(num radius, int subdivisionAxisIndex, int subdivisionAxisCount, num startRadian){
    final double fullRadian = 2*DartMath.PI;
    final double indexPercentage = subdivisionAxisIndex / subdivisionAxisCount;
    final double indexRadian =  indexPercentage * fullRadian;

    final double targetRadian = indexRadian + startRadian;

    final double unitCircleX = DartMath.sin(targetRadian);
    final double radiusCircleX = unitCircleX * radius;
    _x=radiusCircleX;

    final double unitCircleY = DartMath.cos(targetRadian);
    final double radiusCircleY = unitCircleY * radius;
    _y=radiusCircleY;
  }

}