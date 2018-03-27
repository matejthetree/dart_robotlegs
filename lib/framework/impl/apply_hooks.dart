part of robotlegs;

void applyHooks(List<dynamic> hooks, [IInjector injector = null]) {
  hooks.forEach((dynamic hook) {
    if (hook is Function) {
      Function.apply(hook, []);
    }
    if (hook is Type) {
      hook = (injector == null)
          ? injector.instantiateUnmapped(hook as Type)
          : throw new Error(); // todo handle this in guards and hooks, try to avoid direct reflection in robotlegs
    }
    hook.hook();
  });
}
