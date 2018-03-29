//part of robotlegs;
//
//class StageObserver {
//  //-----------------------------------
//  //
//  // Private Static Properties
//  //
//  //-----------------------------------
//
//  ContainerRegistry _registry;
//
//  //-----------------------------------
//  //
//  // Constructor
//  //
//  //-----------------------------------
//
//  StageObserver(this._registry) {
//    _registry.addEventListener(
//        ContainerRegistry.ROOT_CONTAINER_ADD, _onRootContainerAdd);
//    _registry.addEventListener(
//        ContainerRegistry.ROOT_CONTAINER_REMOVE, _onRootContainerRemove);
//
//    _registry.rootBindings
//        .forEach((binding) => _addRootListener(binding.container));
//  }
//
//  //-----------------------------------
//  //
//  // Public Methods
//  //
//  //-----------------------------------
//
//  void destroy() {
//    _registry.removeMessageListener(
//        ContainerRegistry.ROOT_CONTAINER_ADD, _onRootContainerAdd);
//    _registry.removeMessageListener(
//        ContainerRegistry.ROOT_CONTAINER_REMOVE, _onRootContainerRemove);
//
//    _registry.rootBindings
//        .forEach((binding) => _removeRootListener(binding.container));
//  }
//
//  //-----------------------------------
//  //
//  // Private Methods
//  //
//  //-----------------------------------
//
//  void _onRootContainerAdd(Message message) {
//    _addRootListener(message.data as dynamic);
//  }
//
//  void _onRootContainerRemove(Message message) {
//    _removeRootListener(message.data as dynamic);
//  }
//
//  void _addRootListener(dynamic container) {
//    //_watchDomForElementsAdded().then(_onViewAddedToDom);
//    _watchElementForAddingToDom(container).then(_onContainerRootAddedToStage);
//  }
//
//  void _removeRootListener(dynamic container) {
//    //TODO
//  }
//
//  void _onViewAddedToDom(dynamic view) {
//    // TODO: CLEANUP!
//    final Type type = view.runtimeType;
//    final ClassMirror mirror = reflectClass(type);
//    final Symbol symbol = mirror.qualifiedName;
//    final String qcn = MirrorSystem.getName(symbol);
//
//    ContainerBinding binding = _registry.findParentBinding(view);
//
//    while (binding != null) {
//      binding.handleView(view, type);
//      binding = binding.parent;
//    }
//  }
//
//  void _onContainerRootAddedToStage(dynamic container) {
//    // TODO: CLEANUP!
//    final Type type = container.runtimeType;
//    ContainerBinding binding = _registry.getBinding(container);
//    binding.handleView(container, type);
//  }
//
//  Future _watchElementForAddingToDom(dynamic element) {
//    var completer = new Completer();
//
//    new dom.MutationObserver(
//        (List<dom.MutationRecord> mutations, dom.MutationObserver observer) {
//      mutations.forEach((mutationRecord) {
//        mutationRecord.addedNodes.forEach((node) {
//          if (node.nodeName == element.nodeName) {
//            observer.disconnect();
//            completer.complete(element);
//          }
//        });
//      });
//    })
//      ..observe(dom.document, childList: true, subtree: true);
//
//    return completer.future;
//  }
//
///*Future _watchDomForElementsAdded()
//  {
//    var completer = new Completer();
//
//    new dom.MutationObserver((List<dom.MutationRecord> mutations, dom.MutationObserver observer)
//    {
//    	mutations.forEach( (mutationRecord) {
//    		mutationRecord.addedNodes.forEach( (node) {
//    			if (node.nodeName == element.nodeName)
//    			{
//      			observer.disconnect();
//            completer.complete(element);
//    			}
//    		});
//    	});
//    })
//    ..observe(dom.document, childList: true, subtree: true);
//
//    return completer.future;
//  }*/
//}
