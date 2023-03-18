import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'elements.dart';

Future<Object?> buildShowGeneralDialog(
  BuildContext context, {
  required ValueChanged onClosed,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'Sign in',
    barrierDismissible: true,
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, _, __) {
      return const LoginDialog();
    },
  ).then(onClosed);
}

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: _BodyWidget(),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isShowLoading = false;
  bool _isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    artboard.addController(controller!);
    return controller;
  }

  void onPressed() {
    setState(() {
      _isShowLoading = true;
      _isShowConfetti = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_formKey.currentState!.validate()) {
          check.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                _isShowLoading = false;
              });
              confetti.fire();
            },
          );
        } else {
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                _isShowLoading = false;
              });
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            const TitleWidget(),
            const DescriptionWidget(),
            Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const FormWidget(),
                      ButtonWidget(onPressed: onPressed),
                      const DividerWidget(),
                      const OtherWaySignInWidget(),
                    ],
                  ),
                ),
                _isShowLoading
                    ? CustomPositionedWidget(
                        size: 100,
                        child: RiveAnimation.asset(
                          'assets/RiveAssets/check.riv',
                          onInit: (artboard) {
                            StateMachineController controller =
                                getRiveController(artboard);
                            check = controller.findSMI('Check') as SMITrigger;
                            error = controller.findSMI('Error') as SMITrigger;
                            reset = controller.findSMI('Reset') as SMITrigger;
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                _isShowConfetti
                    ? CustomPositionedWidget(
                        child: Transform.scale(
                          scale: 7,
                          child: RiveAnimation.asset(
                            'assets/RiveAssets/confetti.riv',
                            onInit: (artboard) {
                              StateMachineController controller =
                                  getRiveController(artboard);
                              confetti = controller.findSMI('Trigger explosion')
                                  as SMITrigger;
                            },
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ],
        ),
        const ExitIconWidget(),
      ],
    );
  }
}
