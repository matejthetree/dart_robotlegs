part of robotlegs;

class ExtensionInstaller {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  Map<Type, bool> _classes = new Map<Type, bool>();

  IContext _context;

  ILogger _logger;

  IInjector _injector;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  ExtensionInstaller(this._context) {
    _logger = _context.getLogger(this);
    _injector = _context.injector;
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void install(dynamic extension) {
    if (extension is Type) {
      if (_classes[extension] == null)
        install(_injector.instantiateUnmapped(extension));
    } else {
      final Type extensionsClass = extension.runtimeType;
      if (_classes[extensionsClass] != null) return;
      _logger.debug("Installing extension {0}", [extension]);
      _classes[extensionsClass] = true;
      extension.extend(_context);
    }
  }
}
