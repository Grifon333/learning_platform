import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController getRiveController({
    required Artboard artboard,
    required String stateMachineName,
  }) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );
    artboard.addController(controller!);
    return controller;
  }
}
