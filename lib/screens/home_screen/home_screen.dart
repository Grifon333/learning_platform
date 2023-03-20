import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Courses',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courses
                      .map(
                        (course) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: _CourseCard(course: course),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Recent',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ...resentCourses.map(
                (course) => Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: _ResentCourseCard(course: course),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;

  const _CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 260,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: course.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  course.description,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  course.lessonsInfo,
                  style: const TextStyle(color: Colors.white54),
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                    course.avatarsList?.length ?? 0,
                    (index) {
                      return Transform.translate(
                        offset: Offset((-10 * index).toDouble(), 0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            course.avatarsList?[index] ??
                                'assets/avatars/Avatar Default.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(course.iconSrc),
        ],
      ),
    );
  }
}

class _ResentCourseCard extends StatelessWidget {
  final Course course;

  const _ResentCourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: course.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  course.description,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(course.iconSrc),
        ],
      ),
    );
  }
}

class Course {
  String title, description, lessonsInfo, iconSrc;
  Color background;
  List<String>? avatarsList;

  Course({
    required this.title,
    required this.description,
    required this.lessonsInfo,
    required this.iconSrc,
    required this.background,
    required this.avatarsList,
  });
}

List<Course> courses = [
  Course(
    title: 'Animations in SwiftUI',
    description: 'Build and animate an iOS app from scratch',
    lessonsInfo: '61 SECTIONS - 1 HOURS',
    iconSrc: 'assets/icons/ios.svg',
    background: const Color(0xFF7553F6),
    avatarsList: [
      'assets/avatars/Avatar 1.jpg',
      'assets/avatars/Avatar 2.jpg',
      'assets/avatars/Avatar 3.jpg',
    ],
  ),
  Course(
    title: 'Animations in Flutter',
    description: 'Build and animate an iOS app from scratch',
    lessonsInfo: '61 SECTIONS - 1 HOURS',
    iconSrc: 'assets/icons/code.svg',
    background: const Color(0xFF80A4FF),
    avatarsList: [
      'assets/avatars/Avatar 4.jpg',
      'assets/avatars/Avatar 5.jpg',
      'assets/avatars/Avatar 6.jpg',
    ],
  ),
];

List<Course> resentCourses = [
  Course(
    title: 'State Machine',
    description: 'Watch video - 15 mins',
    lessonsInfo: '',
    iconSrc: 'assets/icons/ios.svg',
    background: const Color(0xFF7553F6),
    avatarsList: null,
  ),
  Course(
    title: 'Animated Menu',
    description: 'Watch video - 15 mins',
    lessonsInfo: '',
    iconSrc: 'assets/icons/code.svg',
    background: const Color(0xFF80A4FF),
    avatarsList: null,
  ),
  Course(
    title: 'Flutter with Rive',
    description: 'Watch video - 15 mins',
    lessonsInfo: '',
    iconSrc: 'assets/icons/ios.svg',
    background: const Color(0xFF7553F6),
    avatarsList: null,
  ),
  Course(
    title: 'Animated Menu',
    description: 'Watch video - 15 mins',
    lessonsInfo: '',
    iconSrc: 'assets/icons/code.svg',
    background: const Color(0xFF80A4FF),
    avatarsList: null,
  ),
];
