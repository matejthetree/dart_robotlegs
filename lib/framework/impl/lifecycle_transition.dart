part of robotlegs;

class LifecycleTransition {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final List<String> _fromStates = new List<String>();

  final List _callbacks = [];

  dynamic _eventName;

  Lifecycle _lifecycle;

  String _transitionState;

  String _finalState;

  Symbol _preTransitionEvent;

  Symbol _transitionEvent;

  Symbol _postTransitionEvent;

  bool _reverse = false;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  LifecycleTransition(this._eventName, this._lifecycle);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  LifecycleTransition fromStates(List<String> states) {
    states.forEach((String state) {
      _fromStates.add(state);
    });
    return this;
  }

  LifecycleTransition toStates(String transitionState, String finalState) {
    _transitionState = transitionState;
    _finalState = finalState;
    return this;
  }

  //TODO
  LifecycleTransition withEvents(dynamic preTransitionevent,
      dynamic transitionEvent, dynamic postTransitionEvent) {
    _preTransitionEvent = preTransitionevent;
    _transitionEvent = transitionEvent;
    _postTransitionEvent = postTransitionEvent;

    if (_reverse)
      _lifecycle._addReversedEventTypes(
          [preTransitionevent, transitionEvent, postTransitionEvent]);

    return this;
  }

  LifecycleTransition inReverse() {
    _reverse = true;
    //TODO: _lifecycle.addReversedEventTypes(_preTransitionEvent, _transitionEvent, _postTransitionEvent);
    return this;
  }

  LifecycleTransition addBeforeHandler(EventListener handler) {
    _lifecycle.dispatcher.addEventListener(_eventName, handler);
    return this;
  }

  void enter([EmptyCallback callback]) {
    if (_lifecycle.state == _finalState) {
      callback();
      return;
    }

    if (_lifecycle.state == _transitionState) {
      if (callback != null) _callbacks.add(callback);
      return;
    }

    if (_invalidTransition()) {
      _reportError("Invalid transition");
      return;
    }

    if (callback != null) _callbacks.add(callback);

    _setState(_transitionState);

    _lifecycle.dispatcher.dispatchEvent(_eventName, reverse: _reverse);
    enterCallback();

  }

  EmptyCallback enterCallback() {

    _dispatch(_preTransitionEvent);
    _dispatch(_transitionEvent);

    _setState(_finalState);

    final List<EmptyCallback> callbacks = _callbacks;
    _callbacks.length = 0;

    callbacks.forEach((EmptyCallback callback) {
      callback();
    });

    _dispatch(_postTransitionEvent);

    return null;
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  bool _invalidTransition() {
    return _fromStates.length > 0 &&
        _fromStates.indexOf(_lifecycle.state) == -1;
  }

  void _setState(String state) {
    if (state != null) _lifecycle.setCurrentState(state);
  }

  void _dispatch(dynamic event) {
    if (event != '' && _lifecycle.dispatcher.hasEventListener(event))
      _lifecycle.dispatcher.dispatchEvent(event);
  }

  void _reportError(String message, [ErrorCallback callbacks]) {
    if (_lifecycle.dispatcher.hasEventListener(LifecycleEvent.ERROR))
    {
      _lifecycle.dispatcher.dispatchEvent(LifecycleEvent.ERROR,message: message);
    }
    else
    {
      LifecycleError error = new LifecycleError(message);
      throw error;
    }

  }
}
