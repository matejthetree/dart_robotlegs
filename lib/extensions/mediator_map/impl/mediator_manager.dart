part of robotlegs;

class MediatorManager {
  //-----------------------------------
  //
  // Private Static Properties
  //
  //-----------------------------------

  static Type _ElementType;

  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  MediatorFactory _factory;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  MediatorManager(this._factory);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void addMediator(Mediator mediator, dynamic item, IMediatorMapping mapping) {
    final dynamic element = item as dynamic;

    //TODO: watch element for being removed from DOM

    _initializeMediator(mediator, item);
  }

  void removeMediator(
      Mediator mediator, dynamic item, IMediatorMapping mapping) {
    _destroyMediator(mediator);
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void _initializeMediator(IMediator mediator, dynamic mediatedItem) {
    // TODO: make calling of non-interface methods optional
    mediator.preInitialize();

    mediator.viewComponent = mediatedItem;

    mediator.initialize();

    mediator.postInitialize();
  }

  void _destroyMediator(Mediator mediator) {
    // TODO: make calling of non-interface methods optional
    mediator.preDestroy();

    mediator.destroy();

    mediator.viewComponent = null;

    mediator.postDestroy();
  }
}
