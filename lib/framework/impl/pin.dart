part of robotlegs;

enum PinMessage{
  detain,release
}
class Pin {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final Map<dynamic, bool> _instances = new Map<dynamic, bool>();

  IMessageDispatcher _dispatcher;

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
      _dispatcher.dispatchEvent(PinMessage.detain);
    }
  }

  void release(dynamic instance) {
    if (_instances[instance] != null) {
      _instances.remove(instance);
      _dispatcher.dispatchEvent(PinMessage.release);
    }
  }

  void releaseAll() {
    _instances.forEach((dynamic instance, bool pinned) => release(instance));
  }
}
