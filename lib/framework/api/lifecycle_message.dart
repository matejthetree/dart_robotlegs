part of robotlegs;

enum LifecycleEvent {
  ERROR,
  STATE_CHANGE,
  PRE_INITIALIZE,
  STATIC,
  INITIALIZE,
  POST_INITIALIZE,
  PRE_SUSPEND,
  SUSPEND,
  POST_SUSPEND,
  PRE_RESUME,
  RESUME,
  POST_RESUME,
  PRE_DESTROY,
  DESTROY,
  POST_DESTROY
}
