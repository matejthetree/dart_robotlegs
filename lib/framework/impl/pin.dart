part of robotlegs;

enum PinEvent { detain, release }

class Pin {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final Map<dynamic, bool> _instances = new Map<dynamic, bool>();

  IEventDispatcher _dispatcher;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Pin(this._dispatcher);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void detain(dynamic instance) {
    if (_instances[instance] == null) {
      _instances[instance] = true;
      _dispatcher.dispatchEvent(PinEvent.detain);
    }
  }

  void release(dynamic instance) {
    if (_instances[instance] != null) {
      _instances.remove(instance);
      _dispatcher.dispatchEvent(PinEvent.release);
    }
  }

  void releaseAll() {
    _instances.forEach((dynamic instance, bool pinned) => release(instance));
  }
}
