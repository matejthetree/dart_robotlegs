part of robotlegs;

abstract class IEventCommandMap {
  ICommandMapper map(Type type);

  ICommandUnmapper unmap(Type type);

  IEventCommandMap addMappingProcessor(Function handler);
}
