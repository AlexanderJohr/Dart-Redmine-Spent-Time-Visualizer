part of spend_time_visualizer;

class Padding {
  final num left, right, top, bottom;

  Padding.equalSides(num paddingAll)
      : left = paddingAll,
        right = paddingAll,
        top = paddingAll,
        bottom = paddingAll;

  Padding(this.left, this.right, this.top, this.bottom);
}