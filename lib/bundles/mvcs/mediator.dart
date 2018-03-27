part of robotlegs;

class Mediator implements IMediator {
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  @inject
  IEventDispatcher eventDispatcher;

  dynamic viewComponent;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Mediator();

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void preInitialize() {}

  void initialize() {}

  void postInitialize() {}

  void preDestroy() {}

  void destroy() {}

  void postDestroy() {}

  void dispatch(String event, [dynamic data = null]) {
    eventDispatcher.dispatchEvent(event, data: data);
  }
}
