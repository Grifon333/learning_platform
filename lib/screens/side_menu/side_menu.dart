import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_platform/utils/rive_utils.dart';
import 'package:rive/rive.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  RiveAsset selectCategory = categories.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        decoration: const BoxDecoration(
          color: Color(0xFF17203A),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const _InfoCard(),
              _MenuWidget(
                title: 'BROWSE',
                items: categories,
                isActive: (RiveAsset category) => selectCategory == category,
                updateData: (RiveAsset category) => setState(() {
                  selectCategory = category;
                }),
              ),
              _MenuWidget(
                title: 'HISTORY',
                items: categories2,
                isActive: (RiveAsset category) => selectCategory == category,
                updateData: (RiveAsset category) => setState(() {
                  selectCategory = category;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        'Danylo Korol',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'YouTuber',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final RiveAsset category;
  final ValueChanged<Artboard> onInit;
  final VoidCallback onPress;
  final bool isActive;

  const _CategoryCard({
    Key? key,
    required this.category,
    required this.onPress,
    required this.onInit,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: DecoratedBox(
                decoration: isActive
                    ? BoxDecoration(
                        color: const Color(0xFF6792FF),
                        borderRadius: BorderRadius.circular(10))
                    : const BoxDecoration(),
              ),
            ),
            ListTile(
              onTap: onPress,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  category.scr,
                  artboard: category.artboard,
                  onInit: onInit,
                ),
              ),
              title: Text(
                category.title ?? 'none',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MenuWidget extends StatelessWidget {
  final String title;
  final List<RiveAsset> items;
  final bool Function(RiveAsset item) isActive;
  final Function(RiveAsset item) updateData;

  const _MenuWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.isActive,
    required this.updateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white70),
          ),
        ),
        ...items.map(
          (category) => _CategoryCard(
            category: category,
            onInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                artboard: artboard,
                stateMachineName: category.stateMachineName,
              );
              category.input = controller.findSMI('active') as SMIBool;
            },
            onPress: () {
              category.input.change(true);
              Future.delayed(
                const Duration(seconds: 1),
                () {
                  category.input.change(false);
                },
              );
              updateData(category);
            },
            isActive: isActive(category),
          ),
        ),
      ],
    );
  }
}

List<RiveAsset> categories = [
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'HOME',
    stateMachineName: 'HOME_interactivity',
    title: 'Home',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Search',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'LIKE/STAR',
    stateMachineName: 'STAR_Interactivity',
    title: 'Favorite',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
    title: 'Help',
  ),
];

List<RiveAsset> categories2 = [
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'TIMER',
    stateMachineName: 'TIMER_Interactivity',
    title: 'History',
  ),
  RiveAsset(
    scr: 'assets/RiveAssets/icons.riv',
    artboard: 'BELL',
    stateMachineName: 'BELL_Interactivity',
    title: 'Notification',
  ),
];
