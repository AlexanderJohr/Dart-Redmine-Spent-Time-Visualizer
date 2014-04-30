part of spend_time_visualizer;

abstract class Observable<ArgumentType>{

    final Set<Observer<ArgumentType>> _observerSet = new Set();

    addObserver(Observer<ArgumentType> observer) => _observerSet.add(observer);
    int get observerCount => _observerSet.length;

    deleteObserver(Observer<ArgumentType> observer) => _observerSet.remove(observer);
    deleteObservers() => _observerSet.clear();

    notifyObservers(ArgumentType argument) => _observerSet.forEach((observer) => observer.update(this, argument));

}