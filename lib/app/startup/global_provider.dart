import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Eagerly initialized so that it can be accessed synchronously anytime
final globalProvider = FutureProvider<void>((ref) async {
  await ref.watch(sharedPrefProvider.future);
});

final sharedPrefProvider = FutureProvider((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});
