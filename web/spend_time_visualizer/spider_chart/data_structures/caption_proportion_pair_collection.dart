part of spend_time_visualizer;

class CaptionProportionPairCollection extends Observable<CaptionProportionPair> implements Observer<CaptionProportionPair>{
  List<CaptionProportionPair> _pairs;
  final num fixedMaxProportion;

  set _nonExtendableObservableCaptionProportionPairsList(List<CaptionProportionPair> value){

    List<CaptionProportionPair> listToCopy = value;
    int listlength = listToCopy.length;

    _pairs = new List(listlength);

    for(int i = 0; i < listlength; i++){
      _pairs[i] = listToCopy[i];
    }

    _pairs.forEach((pair) => pair.addObserver(this));
  }

  Map<String, CaptionProportionPair> get nonExtendableObservableCaptionProportionPairsMap{
    int pairsLength = _pairs.length;

    List<CaptionProportionPair> listToCopyFrom = _pairs;
    final Map<String, CaptionProportionPair> mapToCopyIn =
        new Map.fromIterable(listToCopyFrom,
        key: (CaptionProportionPair pairToCopy) => pairToCopy.caption);

    return mapToCopyIn;
  }

  CaptionProportionPairCollection(List<CaptionProportionPair> pairs
                                  , [this.fixedMaxProportion = 0]){
    _nonExtendableObservableCaptionProportionPairsList = pairs;
  }

  num get maxProportion {

    final bool fixedMaxProportionIsSet= fixedMaxProportion != 0;
    if(fixedMaxProportionIsSet){
      return fixedMaxProportion;
    }


    num currentMaxProportion = 0.0;

    for (int i = 0; i < _pairs.length; i++) {
      CaptionProportionPair currentPair = _pairs[i];
      final num currentProportion = currentPair.proportion;

      currentMaxProportion = DartMath.max(currentMaxProportion, currentProportion);
    }

    return currentMaxProportion;
  }

  void update(Observable<CaptionProportionPair> observable, CaptionProportionPair argument) {
    notifyObservers(argument);
  }
}