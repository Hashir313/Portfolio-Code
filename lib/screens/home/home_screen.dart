import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../sections/sections_screen.dart';

import '../../theme/colors.dart';
import '../portfolio_page/portfolio_pages.dart';

/// Custom Typewriter Text Widget
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;
  final Duration startDelay;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 40),
    this.startDelay = Duration.zero,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  int _currentIndex = 0;
  Timer? _timer;
  late VoidCallback _visibilityListener;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();

    // Set up visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('Home') && !_hasStarted) {
        Future.delayed(widget.startDelay, _startTyping);
        _hasStarted = true;
      } else if (!ScreenVisibilityNotifier.instance.isVisible('Home')) {
        // Reset when not visible
        _resetTyping();
      }
    };

    // Add listener for this screen
    ScreenVisibilityNotifier.instance.addListener('Home', _visibilityListener);

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('Home')) {
      Future.delayed(widget.startDelay, _startTyping);
      _hasStarted = true;
    }
  }

  void _startTyping() {
    if (_timer != null) _timer!.cancel();
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _resetTyping() {
    _timer?.cancel();
    if (mounted) {
      setState(() {
        _displayedText = "";
        _currentIndex = 0;
        _hasStarted = false;
      });
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'Home',
      _visibilityListener,
    );
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: widget.style);
  }
}

/// Main Home Screen
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late VoidCallback _visibilityListener;

  @override
  void initState() {
    super.initState();

    // Image fade-in animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Set up visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('Home')) {
        if (!_fadeController.isAnimating && !_fadeController.isCompleted) {
          _fadeController.forward();
        }
      } else {
        // Reset animation when not visible for fresh start next time
        if (_fadeController.isCompleted) {
          _fadeController.reset();
        }
      }
    };

    // Add listener for this screen
    ScreenVisibilityNotifier.instance.addListener('Home', _visibilityListener);

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('Home')) {
      _fadeController.forward();
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'Home',
      _visibilityListener,
    );
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Stack(
      children: [
        Row(
          children: [
            // Left: Sidebar
            Expanded(
              flex: 2,
              child: Container(
                color: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Huzaifa Bin Masood',
                      style: GoogleFonts.pacifico(
                        fontSize: 16.sp,
                        color: secondaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: 2.w,
                      children: [
                        IconButton(
                          onPressed: () async {
                            //? Open LinkedIn profile
                            await launchUrl(
                              Uri.parse(
                                'https://www.linkedin.com/in/huzaifa-bin-masood/',
                              ),
                            );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: secondaryColor,
                            size: 18.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            //? Open LinkedIn profile
                            await launchUrl(
                              Uri.parse(
                                'https://www.instagram.com/huzaifa128?igsh=MW8zc3NueHZ0ZDE1NQ==',
                              ),
                            );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: secondaryColor,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Right: Main Content
            Expanded(
              flex: 4,
              child: Container(
                color: secondaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 4.h,
                ).copyWith(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Consumer(
                      builder: (context, ref, _) => IconButton(
                        icon: Icon(Icons.menu, color: whiteColor, size: 20.sp),
                        onPressed: () {
                          ref.read(isBlurredProvider.notifier).state = true;
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    SizedBox(height: isMobile ? 40.h : 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TypewriterText(
                            text: 'Finance Officer',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            startDelay: const Duration(milliseconds: 200),
                          ),
                          SizedBox(height: 1.h),
                          TypewriterText(
                            text: 'Huzaifa Bin Masood',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                            startDelay: const Duration(milliseconds: 200),
                          ),
                          SizedBox(height: 2.h),
                          TypewriterText(
                            text:
                                "With a sharp eye for financial patterns and a passion for strategic growth, "
                                "I help businesses make sense of complex numbers and turn them into actionable insights. "
                                "Trained in corporate finance and international financial markets, my work bridges financial analysis, "
                                "investment strategies, and regulatory compliance. From conducting audits to modeling multi-market risks, "
                                "I bring both structure and foresight to every project I join - because sometimes, "
                                "it's not the storm you see coming that matters, but how well you’re prepared for it.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                            startDelay: const Duration(milliseconds: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Profile Image with Fade-in Animation
        Positioned.fill(
          child: Align(
            alignment: isMobile ? Alignment.topRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: isMobile ? 50.w : 15.w,
                right: isMobile ? 10.w : 30.w,
                top: isMobile ? 10.h : 0,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/portfolio_image.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
