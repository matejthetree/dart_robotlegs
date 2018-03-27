part of robotlegs;

class RLEventDispatcher implements IEventDispatcher{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  final Map<dynamic, List> _handlers = new Map<dynamic, List>();

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void addEventListener(dynamic event, EventListener handler) {
    final List messageHandlers = _handlers[event];
    if (messageHandlers != null) {
      if (!messageHandlers.contains(handler)) messageHandlers.add(handler);
    } else {
      _handlers[event] = [handler];
    }
  }

  bool hasEventListener(dynamic event) {
    return (_handlers[event] != null);
  }

  void removeEventListener(dynamic event, EventListener handler) {
    final List messageHandlers = _handlers[event];
    int index =
        (messageHandlers != null) ? messageHandlers.indexOf(handler) : -1;
    if (index != -1) {
      messageHandlers.removeAt(index);
      if (messageHandlers.length == 0) _handlers.remove(event);
    }
  }

  void dispatchEvent(dynamic event,{bool reverse = false, dynamic data,dynamic target, String message}) {
    List<EventListener> handlers = _handlers[event];
    if (handlers != null) {
      new RLEventRunner(new Event(event,data: data,target: target,message: message), handlers).run();
    }
  }
}


class RLEventRunner {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final Event _event;

  final List<EventListener> _handlers;


  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  const RLEventRunner(this._event, this._handlers);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void run() {
    _next();
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void _next() {
    EventListener handler = _handlers.removeLast();

    while (handler != null) {
      handler(_event);

      if (_handlers.length > 0)
        handler = _handlers.removeLast();
      else
        handler = null;
    }
  }
}
