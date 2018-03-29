part of robotlegs;

class ContainerBinding extends RLEventDispatcher {
  //-----------------------------------
  //
  // Public Static Properties
  //
  //-----------------------------------

  //-----------------------------------
  // Messages
  //-----------------------------------


  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  ContainerBinding _parent;

  ContainerBinding get parent => _parent;

  set parent(value) => _parent = value;

  dynamic _container;

  dynamic get container => _container;

  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final List<IViewHandler> _viewHandlers = new List<IViewHandler>();

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  ContainerBinding(_container);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void addHandler(IViewHandler handler) {
    if (_viewHandlers.contains(handler)) return;

    _viewHandlers.add(handler);
  }

  void removeHandler(IViewHandler handler) {
    if (_viewHandlers.contains(handler)) {
      _viewHandlers.remove(handler);

      if (_viewHandlers.length == 0) dispatchEvent(ViewManagerEvent.BINDING_EMPTY);
    }
  }

  void handleView(dynamic view, Type type) {
    final int length = _viewHandlers.length;

    for (int i = 0; i < length; i++) {
      IViewHandler handler = _viewHandlers[i];
      handler.handleView(view, type);
    }
  }
}
