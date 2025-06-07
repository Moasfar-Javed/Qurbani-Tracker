part of 'utility.dart';

class EventNotifierUtility {
  static final EventNotifierUtility _instance =
      EventNotifierUtility._internal();

  final Map<Type, Map<Function, Function>> _eventListeners = {};

  factory EventNotifierUtility() {
    return _instance;
  }

  EventNotifierUtility._internal();

  void registerListener<T extends Event>(void Function(T) listener) {
    _eventListeners.putIfAbsent(T, () => {});
    wrappedListener(Event event) {
      if (event is T) {
        listener(event);
      }
    }

    _eventListeners[T]?[listener] = wrappedListener;
  }

  void unregisterListener<T extends Event>(void Function(T) listener) {
    final listeners = _eventListeners[T];
    if (listeners != null) {
      listeners.remove(listener);
      if (listeners.isEmpty) {
        _eventListeners.remove(T);
      }
    }
  }

  void notifyListeners(Event event) {
    final listeners = _eventListeners[event.runtimeType];

    if (listeners != null) {
      for (var listener in listeners.values) {
        listener(event);
      }
    }
  }
}
