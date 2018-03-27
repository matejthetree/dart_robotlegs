part of robotlegs;

class EventDispatcherExtension implements IExtension {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  IContext _context;

  IEventDispatcher _messageDispatcher = new RLEventDispatcher();

  //LifecycleMessageRelay _lifecycleRelay;

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void extend(IContext context) {
    _context = context;
    _context.injector.map(IEventDispatcher).toValue(_messageDispatcher);
    /*_context.beforeInitializing(configureLifecycleEventRelay);
		_context.afterDestroying(destroyLifecycleEventRelay);*/
  }

//-----------------------------------
//
// Private Methods
//
//-----------------------------------

/*void _configureLifecycleEventRelay()
	{
		_lifecycleRelay = new LifecycleEventRelay(_context, _eventDispatcher);
	}
	
	void _destroyLifecycleEventRelay()
	{
		_lifecycleRelay.destroy();
	}*/
}
