part of robotlegs;

class EventCommandTrigger implements ICommandTrigger {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  IEventDispatcher _dispatcher;

  Symbol _name;

  ICommandMappingList _mappings;

  ICommandExecutor _executor;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  EventCommandTrigger(
      IInjector injector, IEventDispatcher dispatcher, Symbol name,
      [List processors = null, ILogger logger = null]) {
    _dispatcher = dispatcher;
    _name = name;
    _mappings = new CommandMappingList(this, processors, logger);
    _executor = new CommandExecutor(injector, _mappings.removeMapping);
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  CommandMapper createMapper() {
    return new CommandMapper(_mappings);
  }

  void activate() {
    _dispatcher.addEventListener(_name, eventHandler);
  }

  void deactivate() {
    _dispatcher.removeEventListener(_name, eventHandler);
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void eventHandler(Event event) {
    final Type eventDataType = event.data.runtimeType;

    _executor.executeCommands(_mappings.getList(),
        new CommandPayload([event.data], [eventDataType]));
  }
}
