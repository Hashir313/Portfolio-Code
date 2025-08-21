import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../sections/sections_screen.dart';

/// Reusable Typewriter Animation Widget
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
      if (ScreenVisibilityNotifier.instance.isVisible('About') &&
          !_hasStarted) {
        Future.delayed(widget.startDelay, _startTyping);
        _hasStarted = true;
      } else if (!ScreenVisibilityNotifier.instance.isVisible('About')) {
        // Reset when not visible
        _resetTyping();
      }
    };

    // Add listener for this screen
    ScreenVisibilityNotifier.instance.addListener('About', _visibilityListener);

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('About')) {
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
      'About',
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

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _lineFadeController;
  late Animation<double> _lineFadeAnimation;

  late AnimationController _imageController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late VoidCallback _visibilityListener;

  @override
  void initState() {
    super.initState();

    // Top circles + line fade-in
    _lineFadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _lineFadeAnimation = CurvedAnimation(
      parent: _lineFadeController,
      curve: Curves.easeIn,
    );

    // Image fade + slide from right
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));
    _fadeAnimation = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeIn,
    );

    // Set up visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('About')) {
        if (!_lineFadeController.isAnimating &&
            !_lineFadeController.isCompleted) {
          _lineFadeController.forward();
        }
        if (!_imageController.isAnimating && !_imageController.isCompleted) {
          _imageController.forward();
        }
      } else {
        // Reset animations when not visible for fresh start next time
        if (_lineFadeController.isCompleted) {
          _lineFadeController.reset();
        }
        if (_imageController.isCompleted) {
          _imageController.reset();
        }
      }
    };

    // Add listener for this screen
    ScreenVisibilityNotifier.instance.addListener('About', _visibilityListener);

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('About')) {
      _lineFadeController.forward();
      _imageController.forward();
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'About',
      _visibilityListener,
    );
    _lineFadeController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 10.h,
      ).copyWith(bottom: 0),
      color: secondaryColor,
      child: Column(
        children: [
          // Circles + line
          FadeTransition(
            opacity: _lineFadeAnimation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 0.8.w,
                  height: 0.8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  width: 0.8.w,
                  height: 0.8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Container(
                    height: 0.5.w,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(0.4.w),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 10.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: text
                SizedBox(
                  width: 40.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypewriterText(
                        text: 'Who I am',
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0.sp,
                        ),
                        startDelay: const Duration(milliseconds: 200),
                      ),
                      SizedBox(height: 5.h),
                      TypewriterText(
                        text:
                            'Hi, I’m Huzaifa Bin Masood, a finance professional currently based in Paris, France.\n\n'
                            'By day, I’m pursuing a Master’s in International Corporate Finance at ESCE, diving deep into global markets, risk management, and strategic finance. '
                            'Previously, I’ve worked in audit and financial consulting roles, where I helped companies stay compliant, optimize their finances, and make smarter investment decisions.\n'
                            'In my free time, I explore data analysis using tools like Jamovi, sharpen my skills in financial modeling, and stay curious about international investment trends. '
                            'My long-term goal? To craft innovative financial strategies that drive sustainable growth for businesses around the world.',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0.sp,
                          height: 1.5,
                        ),
                        startDelay: const Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 2.w),

                // Right side: image with animation
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SvgPicture.asset(
                      'assets/about.svg',
                      width: 30.w,
                      height: 30.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
