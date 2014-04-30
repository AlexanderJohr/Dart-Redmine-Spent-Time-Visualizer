part of spend_time_visualizer;

class CaptionProportionPair extends Observable<CaptionProportionPair>{
  final String caption;
  num _proportion;

  num get proportion => _proportion;
         set proportion(num value){
           _proportion = value;
           notifyObservers(this);
         }

  CaptionProportionPair(this.caption, this._proportion){}

  toString() => "$caption has $proportion.";
}