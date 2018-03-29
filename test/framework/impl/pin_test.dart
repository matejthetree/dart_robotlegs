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
    // ignore: use_of_void_result
    expect(verify(dispatcher.dispatchEvent(PinEvent.detain)), isTrue);
  });
}
