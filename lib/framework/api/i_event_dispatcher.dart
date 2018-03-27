part of robotlegs;

typedef void EventListener(Event) ;

class Event {
  final String event;
  final dynamic data;
  final String message;
  final dynamic target;

  const Event(this.event, {this.data,this.message,this.target});


}
abstract class IEventDispatcher {
  void dispatchEvent(dynamic event,
  {dynamic data, String message, dynamic target, bool reverse = false});
  void removeEventListener(dynamic message, EventListener handler);
  bool hasEventListener(dynamic message);
  void addEventListener(dynamic message, EventListener handler);
}
