import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../experience/experience_screen.dart';
import '../home/home_screen.dart';
import '../about/about_screen.dart';
import '../education/education_screen.dart';
import '../contact/contact_screen.dart';
import '../skills/skills_screen.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final Color color;

  const SectionWidget({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return VisibilityDetector(
      key: Key('section-$title'),
      onVisibilityChanged: (VisibilityInfo info) {
        // Notify the screen when it becomes visible (>50% visible)
        if (info.visibleFraction > 0.5) {
          _notifyScreenVisibility(title, true);
        } else {
          _notifyScreenVisibility(title, false);
        }
      },
      child: SizedBox(
        height: title == "Education"
            ? screenHeight * 0.8
            : title == "Experience"
            ? screenHeight *
                  1.2 // 👈 yahan 120% height di
            : screenHeight,
        child: Builder(
          builder: (context) {
            switch (title) {
              case 'Home':
                return HomeScreen(key: ValueKey('home-screen'));
              case 'About':
                return AboutScreen(key: ValueKey('about-screen'));
              case 'Education':
                return EducationScreen(key: ValueKey('education-screen'));
              case 'Skills':
                return SkillsScreen(key: ValueKey('skills-screen'));
              case 'Experience':
                return ExperienceScreen(key: ValueKey('experience-screen'));
              case 'Contact':
                return ContactScreen(key: ValueKey('contact-screen'));
              default:
                return Container(
                  color: color,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  void _notifyScreenVisibility(String screenName, bool isVisible) {
    // This will be used to communicate with individual screens
    // We'll use a simple notification mechanism
    ScreenVisibilityNotifier.instance.notifyVisibility(screenName, isVisible);
  }
}

// Singleton class to manage screen visibility notifications
class ScreenVisibilityNotifier {
  static final ScreenVisibilityNotifier instance =
      ScreenVisibilityNotifier._internal();
  factory ScreenVisibilityNotifier() => instance;
  ScreenVisibilityNotifier._internal();

  final Map<String, bool> _visibilityMap = {};
  final Map<String, List<VoidCallback>> _listeners = {};

  void notifyVisibility(String screenName, bool isVisible) {
    _visibilityMap[screenName] = isVisible;
    final listeners = _listeners[screenName] ?? [];
    for (final listener in listeners) {
      listener();
    }
  }

  bool isVisible(String screenName) {
    return _visibilityMap[screenName] ?? false;
  }

  void addListener(String screenName, VoidCallback listener) {
    _listeners[screenName] ??= [];
    _listeners[screenName]!.add(listener);
  }

  void removeListener(String screenName, VoidCallback listener) {
    _listeners[screenName]?.remove(listener);
  }
}
