import 'package:mockito/mockito.dart';
import 'package:robotlegs/robotlegs.dart';
import 'package:test/test.dart';

import 'objects/objects.dart';

pinTestCase() {
  Pin pin;
  Object instance;

  IEventDispatcher dispatcher;

  setUp(() {
    instance = {};
    dispatcher = new MockDispatcher();
    pin = new Pin(dispatcher);
  });

  test("detain dispatches event", () {
    pin.detain(instance);
    var verify2 = verify(dispatcher.dispatchEvent(PinEvent.detain));
    expect(verify2.callCount, equals(1));
  });

  test("detain dispatches event once per valid detainment", () {
    pin.detain(instance);
    pin.detain(instance);
    var verify2 = verify(dispatcher.dispatchEvent(PinEvent.detain));
    expect(verify2.callCount, equals(1));
  });

  test("release dispatches event", () {
    pin.detain(instance);
    pin.release(instance);
    var verify2 = verify(dispatcher.dispatchEvent(PinEvent.release));
    expect(verify2.callCount, equals(1));
  });

  test("release dispatches event once per valid detainment", () {
    pin.detain(instance);
    pin.release(instance);
    pin.release(instance);
    var verify2 = verify(dispatcher.dispatchEvent(PinEvent.release));
    expect(verify2.callCount, equals(1));
  });

  test("release does not dispatches event if instance was not detained", () {
    pin.release(instance);
    var verify2 = verifyNever(dispatcher.dispatchEvent(PinEvent.release));
    expect(verify2.callCount, equals(0));
  });

  test("release dispatches events for all instances", () {
    final instanceA = new Object();
    final instanceB = new Object();
    final instanceC = new Object();

    pin.detain(instanceA);
    pin.detain(instanceB);
    pin.detain(instanceC);
    pin.releaseAll();

    var verify2 = verify(dispatcher.dispatchEvent(PinEvent.release));
    expect(verify2.callCount, equals(3));
  });
}
