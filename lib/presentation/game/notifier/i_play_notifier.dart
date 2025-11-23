abstract class IPlayNotifier {
  void tick(int index, Future<void> Function() winningAnimationCallback);
}
