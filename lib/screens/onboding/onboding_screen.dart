import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({Key? key}) : super(key: key);

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //---------------BACKGROUND-------------------------------------
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
          // -------------------BODY-------------------------------------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: const [
                  _TitleAndDescriptionWidget(),
                  
                ],
              ),
            ),
          ),
        ],
      ),
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
