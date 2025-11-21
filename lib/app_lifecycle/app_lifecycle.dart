import 'package:betclictactoe/ui/shared/controllers/audio_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLifecycleObserver extends ConsumerStatefulWidget {
  final Widget child;

  const AppLifecycleObserver({required this.child, super.key});

  @override
  ConsumerState<AppLifecycleObserver> createState() =>
      _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends ConsumerState<AppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final audioControllerNotifier = ref.read(audioControllerProvider.notifier);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        audioControllerNotifier.handleAppPaused();
      case AppLifecycleState.resumed:
        audioControllerNotifier.handleAppResumed();
      case AppLifecycleState.inactive:
        break;
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
