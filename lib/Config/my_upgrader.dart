import 'package:upgrader/upgrader.dart';

/// This class extends / subclasses Upgrader.
class MyUpgrader extends Upgrader {
  MyUpgrader()
      : super(
          debugLogging: true,
          // canDismissDialog: false,
          // showIgnore: false,
          durationUntilAlertAgain: const Duration(minutes: 2),
        );

  /// This method overrides super class method.
  // @override
  // void popNavigator(BuildContext context) {
  //   debugPrint('this method overrides popNavigator');
  //   super.popNavigator(context);
  // }
}
