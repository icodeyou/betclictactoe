class AppConstants {
  /// Logging
  static const int logStacktraceNumber = 2;

  /// Audio
  ///
  /// [polyphony] is to configure the number of sound effects (SFX) that can
  /// play at the same time. If you choose `1`, it will always only play one
  /// sound (a new sound will stop the previous one). Background music does not 
  /// count into the [polyphony] limit.
  /// This value should be at least `1`.
  static const int polyphony = 2;
}
