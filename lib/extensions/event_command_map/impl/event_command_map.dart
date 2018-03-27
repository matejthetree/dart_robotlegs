part of robotlegs;

class EventCommandMap implements IEventCommandMap {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final List _mappingProcessors = [];

  IInjector _injector;

  IEventDispatcher _dispatcher;

  CommandTriggerMap _triggerMap;

  ILogger _logger;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  EventCommandMap(IContext context, IEventDispatcher dispatcher) {
    _injector = context.injector;
    _logger = context.getLogger(this);
    _dispatcher = dispatcher;
    _triggerMap = new CommandTriggerMap(_injector.getQualifiedName, _createTrigger);
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  ICommandMapper map(Type type) {
    return _getTrigger(type).createMapper();
  }

  ICommandUnmapper unmap(Type type) {
    return _getTrigger(type).createMapper();
  }

  IEventCommandMap addMappingProcessor(Function handler) {
    if (!_mappingProcessors.contains(handler)) _mappingProcessors.add(handler);

    return this;
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  EventCommandTrigger _getTrigger(Type name) {
    return _triggerMap.getTrigger([name]) as EventCommandTrigger;
  }

  EventCommandTrigger _createTrigger(Symbol name) {
    return new EventCommandTrigger(
        _injector, _dispatcher, name, _mappingProcessors, _logger);
  }
}
