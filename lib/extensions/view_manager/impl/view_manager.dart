part of robotlegs;

class ViewManager extends RLEventDispatcher implements IViewManager {
  //-----------------------------------
  //
  // Public Static Properties
  //
  //-----------------------------------

  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  final List<dynamic> _containers = new List<dynamic>();

  List<dynamic> get containers => _containers;

  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final List<IViewHandler> _viewHandlers = new List<IViewHandler>();

  ContainerRegistry _registry;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  ViewManager(this._registry);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void addContainer(dynamic container) {
    if (!_validContainer(container)) return;

    _containers.add(container);

    _viewHandlers.forEach((handler) {
      _registry.addContainer(container).addHandler(handler);
    });

    dispatchEvent(ViewManagerEvent.CONTAINER_ADD, data: container);
  }

  void removeContainer(dynamic container) {
    if (!_containers.contains(container)) return;

    _containers.remove(container);

    final ContainerBinding binding = _registry.getBinding(container);
    _viewHandlers.forEach((handler) {
      binding.removeHandler(handler);
    });

    dispatchEvent(ViewManagerEvent.CONTAINER_REMOVE, data: container);
  }

  void addViewHandler(IViewHandler handler) {
    if (_viewHandlers.contains(handler)) return;

    _viewHandlers.add(handler);

    _containers.forEach((container) {
      _registry.addContainer(container).addHandler(handler);
    });

    dispatchEvent(ViewManagerEvent.HANDLER_ADD, data: handler);
  }

  void removeViewHandler(IViewHandler handler) {
    if (!_viewHandlers.contains(handler)) return;

    _viewHandlers.remove(handler);

    _containers.forEach((container) {
      _registry.getBinding(container).removeHandler(handler);
    });

    dispatchEvent(ViewManagerEvent.HANDLER_REMOVE, data: handler);
  }

  void removeAllHandlers() {
    _containers.forEach((container) {
      final ContainerBinding binding = _registry.getBinding(container);

      _viewHandlers.forEach((handler) {
        binding.removeHandler(handler);
      });
    });
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  bool _validContainer(dynamic container) {
    _containers.forEach((registeredContainer) {
      if (container == registeredContainer) return false;

      if (registeredContainer.contains(container) ||
          container.contains(registeredContainer)) throw new Error();
    });
    return true;
  }
}
