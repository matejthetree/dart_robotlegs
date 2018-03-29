part of robotlegs;
enum ViewManagerEvent{
  CONTAINER_ADD,
  CONTAINER_REMOVE,
  HANDLER_ADD,
  HANDLER_REMOVE,
  ROOT_CONTAINER_ADD,
  ROOT_CONTAINER_REMOVE,
  BINDING_EMPTY
}

abstract class IViewManager {
  List<dynamic> get containers;

  void addContainer(dynamic container);

  void removeContainer(dynamic container);

  void addViewHandler(IViewHandler handler);

  void removeViewHandler(IViewHandler handler);

  void removeAllHandlers();
}
