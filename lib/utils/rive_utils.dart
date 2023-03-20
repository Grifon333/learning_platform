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

class RiveAsset {
  String scr, artboard, stateMachineName;
  String? title;
  late SMIBool input;

  RiveAsset({
    required this.scr,
    required this.artboard,
    required this.stateMachineName,
    this.title,
  });

  set setInput(SMIBool status) => input = status;
}
