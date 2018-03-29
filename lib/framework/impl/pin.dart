part of robotlegs;

enum PinEvent { detain, release }

class Pin {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final HashMap<int, bool> _instances = new HashMap<int, bool>();

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
    if (_instances[instance.hashCode] == null) {
      _addHashCode(instance.hashCode);
      _dispatcher.dispatchEvent(PinEvent.detain);
    }
  }

  void release(dynamic instance) {
    if (_instances[instance.hashCode] != null) {
      _releaseHashCode(instance.hashCode);
      _dispatcher.dispatchEvent(PinEvent.release);
    }
  }

  void releaseAll() {
    var tempMap = new HashMap<int, bool>()..addAll(_instances);
    tempMap.forEach((int hashCode, bool value) {
      _releaseHashCode(hashCode);
      _dispatcher.dispatchEvent(PinEvent.release);
    });
    tempMap.clear();
    tempMap = null;
  }

  void _releaseHashCode(int hashCode) => _instances.remove(hashCode);

  void _addHashCode(int hashCode) => _instances[hashCode] = true;
}
