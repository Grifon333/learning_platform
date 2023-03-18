import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 34,
        fontFamily: 'Poppins',
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'Access to 240+ hours of content. Learn design and code, by '
        'building real apps with Flutter and Swift.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget({Key? key}) : super(key: key);

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
            validator: (value) {
              if (value!.isEmpty) {
                return "";
              }
              return null;
            },
            onSaved: (email) {},
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
            validator: (value) {
              if (value!.isEmpty) {
                return "";
              }
              return null;
            },
            onSaved: (password) {},
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

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
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

class ExitIconWidget extends StatelessWidget {
  const ExitIconWidget({Key? key}) : super(key: key);

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

class CustomPositionedWidget extends StatelessWidget {
  final double size;
  final Widget child;

  const CustomPositionedWidget({
    Key? key,
    this.size = 100,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 24,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
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

class OtherWaySignInWidget extends StatelessWidget {
  const OtherWaySignInWidget({Key? key}) : super(key: key);

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