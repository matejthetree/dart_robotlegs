part of robotlegs;

class StageCrawler {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  ContainerBinding _binding;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  StageCrawler(this._binding);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void scan(dynamic view) {
    _scanContainer(view);
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void _scanContainer(dynamic container) {
    _processView(container);
    final int numChildren = container.children.length;

    for (int i = 0; i < numChildren; i++) {
      final dynamic child = container.children[i];
//      child is dynamic ? _scanContainer(child) : _processView(child);
//    todo, makes an interface for root and for child
    }
  }

  void _processView(dynamic view) {
    _binding.handleView(view, view.runtimeType);
  }
}
