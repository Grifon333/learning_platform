import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_platform/constants.dart';
import 'package:learning_platform/screens/home_screen/home_screen.dart';
import 'package:learning_platform/screens/side_menu/side_menu.dart';
import 'package:learning_platform/utils/rive_utils.dart';
import 'package:rive/rive.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late SMIBool _isClose;
  bool _isOpenSideBar = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: _isOpenSideBar ? 0 : -288,
            height: MediaQuery.of(context).size.height,
            child: const SideMenuWidget(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value - 30 * _animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(_animation.value * 265, 0),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: const HomeScreen(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 16,
            left: _isOpenSideBar ? 220 : 0,
            curve: Curves.fastOutSlowIn,
            child: _MenuButtonWidget(
              onTap: () {
                _isClose.value ^= true;
                if (_isOpenSideBar) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                setState(() {
                  _isOpenSideBar = !_isClose.value;
                });
              },
              onInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                  artboard: artboard,
                  stateMachineName: 'State Machine',
                );
                _isClose = controller.findSMI('isOpen') as SMIBool;
                _isClose.value = true;
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * _animation.value),
        child: const _BottomBarWidget(),
      ),
    );
  }
}

class _BottomBarWidget extends StatefulWidget {
  const _BottomBarWidget({Key? key}) : super(key: key);

  @override
  State<_BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<_BottomBarWidget> {
  RiveAsset selectBottomItem = bottomNavigation.first;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor2.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              bottomNavigation.length,
              (index) {
                bool isSelect = selectBottomItem == bottomNavigation[index];
                return GestureDetector(
                  onTap: () {
                    bottomNavigation[index].input.change(true);
                    if (selectBottomItem != bottomNavigation[index]) {
                      setState(() {
                        selectBottomItem = bottomNavigation[index];
                      });
                    }
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        bottomNavigation[index].input.change(false);
                      },
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _TopIdentifier(
                        isSelect: isSelect,
                      ),
                      _IconOfBottomNavigation(
                        isSelect: isSelect,
                        item: bottomNavigation[index],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TopIdentifier extends StatelessWidget {
  final bool isSelect;

  const _TopIdentifier({
    Key? key,
    required this.isSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isSelect ? 20 : 0,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF81B4FF),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _IconOfBottomNavigation extends StatelessWidget {
  final bool isSelect;
  final RiveAsset item;

  const _IconOfBottomNavigation({
    Key? key,
    required this.isSelect,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 36,
      child: Opacity(
        opacity: isSelect ? 1 : 0.5,
        child: RiveAnimation.asset(
          item.scr,
          artboard: item.artboard,
          onInit: (artboard) {
            StateMachineController controller = RiveUtils.getRiveController(
              artboard: artboard,
              stateMachineName: item.stateMachineName,
            );
            item.input = controller.findSMI('active') as SMIBool;
          },
        ),
      ),
    );
  }
}

class _MenuButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ValueChanged<Artboard> onInit;

  const _MenuButtonWidget({
    Key? key,
    required this.onTap,
    required this.onInit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SafeArea(
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            'assets/RiveAssets/menu_button.riv',
            onInit: onInit,
          ),
        ),
      ),
    );
  }
}

List<RiveAsset> bottomNavigation = [
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'TIMER',
    stateMachineName: 'TIMER_Interactivity',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'BELL',
    stateMachineName: 'BELL_Interactivity',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'USER',
    stateMachineName: 'USER_Interactivity',
  )
];
