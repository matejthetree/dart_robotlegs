part of robotlegs;

class Lifecycle extends RLEventDispatcher implements ILifecycle {
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  String _state = LifecycleState.UNINITIALIZED;

  String get state => _state;

  dynamic _target;

  dynamic get target => _target;

  bool get uninitialized => (_state == LifecycleState.UNINITIALIZED);

  bool get initialized =>
      _state != LifecycleState.UNINITIALIZED &&
      _state != LifecycleState.INITIALIZING;

  bool get active => _state == LifecycleState.ACTIVE;

  bool get suspended => _state == LifecycleState.SUSPENDED;

  bool get destroyed => _state == LifecycleState.DESTROYED;

  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  final Map _reversedEventTypes = new Map();

  int _reversePriority;

  LifecycleTransition _initialize;

  LifecycleTransition _suspend;

  LifecycleTransition _resume;

  LifecycleTransition _destroy;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Lifecycle() {

    _configureTransitions();
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void initialize([EmptyCallback callback]) {
    _initialize.enter(callback);
  }

  void suspend([EmptyCallback callback]) {
    _suspend.enter(callback);
  }

  void resume([EmptyCallback callback]) {
    _resume.enter(callback);
  }

  void destroy([EmptyCallback callback]) {
    _destroy.enter(callback);
  }

  ILifecycle beforeInitializing(EventListener handler) {
    if (!uninitialized) _reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);

    _initialize.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenInitializing(EventListener handler) {
    if (initialized) _reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
    addEventListener(
        LifecycleEvent.INITIALIZE, handler);
    return this;
  }

  ILifecycle afterInitializing(EventListener handler) {
    if (initialized) _reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
    addEventListener(
        LifecycleEvent.POST_INITIALIZE, handler);
    return this;
  }

  ILifecycle beforeSuspending(EventListener handler) {
    _suspend.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenSuspending(EventListener handler) {
    addEventListener(
        LifecycleEvent.SUSPEND, handler);
    return this;
  }

  ILifecycle afterSuspending(EventListener handler) {
    addEventListener(
        LifecycleEvent.POST_SUSPEND, handler);
    return this;
  }

  ILifecycle beforeResuming(EventListener handler) {
    _resume.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenResuming(EventListener handler) {
    addEventListener(
        LifecycleEvent.RESUME, handler);
    return this;
  }

  ILifecycle afterResuming(EventListener handler) {
    addEventListener(
        LifecycleEvent.POST_RESUME, handler);
    return this;
  }

  ILifecycle beforeDestroying(EventListener handler) {
    _destroy.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenDestroying(EventListener handler) {
    addEventListener(
        LifecycleEvent.DESTROY, handler);
    return this;
  }

  ILifecycle afterDestroying(EventListener handler) {
    addEventListener(
        LifecycleEvent.POST_DESTROY, handler);
    return this;
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void setCurrentState(String state) {
    if (_state == state) return;
    _state = state;

    dispatchEvent(LifecycleEvent.STATE_CHANGE);
  }

  void _addReversedEventTypes(List types) {
    types.forEach((type) {
      _reversedEventTypes[type] = true;
    });
  }

  void _configureTransitions() {
    _initialize = new LifecycleTransition(LifecycleEvent.PRE_INITIALIZE, this)
        .fromStates([LifecycleState.UNINITIALIZED])
        .toStates(LifecycleState.INITIALIZING, LifecycleState.ACTIVE)
        .withEvents(LifecycleEvent.PRE_INITIALIZE,
            LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE);

    _suspend = new LifecycleTransition(LifecycleEvent.PRE_SUSPEND, this)
        .fromStates([LifecycleState.ACTIVE])
        .toStates(LifecycleState.SUSPENDING, LifecycleState.SUSPENDED)
        .withEvents(LifecycleEvent.PRE_SUSPEND, LifecycleEvent.SUSPEND,
            LifecycleEvent.POST_SUSPEND)
        .inReverse();

    _resume = new LifecycleTransition(LifecycleEvent.PRE_RESUME, this)
        .fromStates([LifecycleState.SUSPENDED])
        .toStates(LifecycleState.RESUMING, LifecycleState.ACTIVE)
        .withEvents(LifecycleEvent.PRE_RESUME, LifecycleEvent.RESUME,
            LifecycleEvent.POST_RESUME);

    _destroy = new LifecycleTransition(LifecycleEvent.PRE_DESTROY, this)
        .fromStates([LifecycleState.SUSPENDED, LifecycleState.ACTIVE])
        .toStates(LifecycleState.DESTROYING, LifecycleState.DESTROYED)
        .withEvents(LifecycleEvent.PRE_DESTROY, LifecycleEvent.DESTROY,
            LifecycleEvent.POST_DESTROY)
        .inReverse();
  }

  int flipPriority(String type, int priority) {
    return (priority == 0 && _reversedEventTypes[type])
        ? _reversePriority++
        : priority;
  }


  void _reportError(String message) {
    LifecycleError error = new LifecycleError(message);
		if (hasEventListener(LifecycleEvent.ERROR))
		{
			dispatchEvent(LifecycleEvent.ERROR,payload: message);
  	}
  	else
  	{
  		throw error;
  	}
  }
}
