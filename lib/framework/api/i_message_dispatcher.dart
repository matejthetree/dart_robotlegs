part of robotlegs;

typedef EventListener(dynamic event, [dynamic payload]);

abstract class IMessageDispatcher {
  void dispatchEvent(dynamic message,
  {dynamic payload, bool reverse = false});
  void removeEventListener(dynamic message, EventListener handler);
  bool hasEventListener(dynamic message);
  void addEventListener(dynamic message, EventListener handler);
}
