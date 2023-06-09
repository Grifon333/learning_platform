import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learning_platform/screens/login_dialog/login_dialog.dart';
import 'package:rive/rive.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  late RiveAnimationController _buttonController;
  bool _isSingInDialogShow = false;

  @override
  void initState() {
    _buttonController = OneShotAnimation(
      'active',
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Background(),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 240),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          top: _isSingInDialogShow ? -50 : 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const _TitleAndDescriptionWidget(),
                  const Spacer(flex: 2),
                  _ButtonWidget(
                    buttonController: _buttonController,
                    press: () {
                      _buttonController.isActive = true;
                      Future.delayed(
                        const Duration(milliseconds: 800),
                        () {
                          setState(() {
                            _isSingInDialogShow = true;
                          });
                          buildShowGeneralDialog(
                            context,
                            onClosed: (_) {
                              setState(() {
                                _isSingInDialogShow = false;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'Purchase includes access to 30+ courses, 240+ premium '
                      'tutorial, 120+ hours of videos, source files or '
                      'certificates.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: MediaQuery.of(context).size.width * 1.7,
          bottom: 200,
          left: 100,
          child: Image.asset('assets/backgrounds/Spline.png'),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 10,
            ),
          ),
        ),
        const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50,
              sigmaY: 50,
            ),
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }
}

class _TitleAndDescriptionWidget extends StatelessWidget {
  const _TitleAndDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Column(
        children: const [
          Text(
            'Learn design & code',
            style: TextStyle(fontSize: 60, fontFamily: 'Poppins', height: 1.2),
          ),
          SizedBox(height: 16),
          Text('Don\'t skip design. Learn design and code, by building '
              'real apps with Flutter and Swift Complete courses about '
              'the best tools.'),
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  final RiveAnimationController _buttonController;
  final VoidCallback press;

  const _ButtonWidget({
    Key? key,
    required RiveAnimationController buttonController,
    required this.press,
  })  : _buttonController = buttonController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              'assets/RiveAssets/button.riv',
              controllers: [_buttonController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_forward),
                  SizedBox(width: 8),
                  Text(
                    'Start the course',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
