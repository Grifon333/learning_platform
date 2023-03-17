import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<Object?> buildShowGeneralDialog(
    BuildContext context, {
      required ValueChanged onClosed,
    }) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'Sign in',
    barrierDismissible: true,
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween =
      Tween(begin: const Offset(0, -1), end: Offset.zero);
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Access to 240+ hours of content. Learn design and code, by '
                      'building real apps with Flutter and Swift.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Form(
                    child: Column(
                      children: const [
                        _FormWidget(),
                        _ButtonWidget(),
                        _DividerWidget(),
                        _OtherWaySignInWidget(),
                      ],
                    ),
                  ),
                ],
              ),
              _ExitIconWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 16,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset('assets/icons/email.svg'),
              ),
            ),
          ),
        ),
        const Text(
          'Password',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  'assets/icons/password.svg',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 24,
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.arrow_right,
          color: Colors.red,
        ),
        label: const Text('Sing in'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFFF77D8E),
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 56),
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerWidget extends StatelessWidget {
  const _DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.black26,
            ),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class _OtherWaySignInWidget extends StatelessWidget {
  const _OtherWaySignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Sign up with Email, Apple or Google',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/email_box.svg',
                height: 64,
                width: 64,
              ),
              padding: EdgeInsets.zero,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/apple_box.svg',
                height: 64,
                width: 64,
              ),
              padding: EdgeInsets.zero,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/google_box.svg',
                height: 64,
                width: 64,
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ],
    );
  }
}

class _ExitIconWidget extends StatelessWidget {
  const _ExitIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      left: 0,
      right: 0,
      bottom: -48,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
    );
  }
}
