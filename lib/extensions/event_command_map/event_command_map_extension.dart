part of robotlegs;

class MessageCommandMapExtension implements IExtension {
  void extend(IContext context) {
    context.injector.map(IEventCommandMap).toSingleton(EventCommandMap);
  }
}