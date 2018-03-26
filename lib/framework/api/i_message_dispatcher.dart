part of robotlegs;

abstract class IMessageDispatcher {
  void dispatchMessage(dynamic message,
      [Function callback = null, bool reverse = false]);
  void removeMessageHandler(dynamic message, Function handler);
  bool hasMessageHandler(dynamic message);
  void addMessageHandler(dynamic message, Function handler);
}
