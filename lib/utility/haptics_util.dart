part of 'utility.dart';

class HapticUtil {
  static Future<void> trigger(Haptics haptic) async {
    switch (haptic) {
      case Haptics.selection:
        await _selection();
        break;
      case Haptics.vibrate:
        await _vibrate();
        break;
      case Haptics.nudge:
        await _nudge();
        break;
      case Haptics.success:
        await _success();
        break;
      case Haptics.error:
        await _error();
        break;
    }
  }

  static Future<void> _selection() async {
    await HapticFeedback.selectionClick();
  }

  static Future<void> _vibrate() async {
    await HapticFeedback.vibrate();
  }

  static Future<void> _nudge() async {
    await HapticFeedback.lightImpact();
  }

  static Future<void> _success() async {
    await HapticFeedback.mediumImpact();
  }

  static Future<void> _error() async {
    await HapticFeedback.heavyImpact();
  }
}
