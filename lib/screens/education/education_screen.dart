import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../sections/sections_screen.dart';

import 'widget/education_card.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late VoidCallback _visibilityListener;

  @override
  void initState() {
    super.initState();

    // Fade animation for screen
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Set up visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('Education')) {
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
    ScreenVisibilityNotifier.instance.addListener(
      'Education',
      _visibilityListener,
    );

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('Education')) {
      _fadeController.forward();
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'Education',
      _visibilityListener,
    );
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      color: secondaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 2.h,
      ).copyWith(bottom: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Small screen (mobile)
            return Column(
              children: [
                _buildEducationContent(),
                SizedBox(height: 3.h),
                FadeTransition(
                  opacity: _fadeController,
                  child: SvgPicture.asset(
                    'assets/education.svg',
                    width: 80.w,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          } else {
            // Larger screen
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildEducationContent()),
                SizedBox(width: 5.w),
                FadeTransition(
                  opacity: _fadeController,
                  child: SvgPicture.asset(
                    'assets/education.svg',
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildEducationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5.h),

        // Animated cards
        AnimatedEducationCard(
          title: 'Master’s in International Corporate Finance',
          subtitle: 'ESCE, Paris, France',
          date: '2025 - Present',
          delay: 300,
        ),
        SizedBox(height: 2.h),
        AnimatedEducationCard(
          title: 'Bachelor’s of Business Administration(BBA -Finance)',
          subtitle: 'University of XYZ, Country',
          date: '2019 - 2023',
          delay: 600,
        ),
      ],
    );
  }
}

/// Custom Animated Card with hover + entry animation
class AnimatedEducationCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String date;
  final int delay;

  const AnimatedEducationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.delay = 0,
  });

  @override
  State<AnimatedEducationCard> createState() => _AnimatedEducationCardState();
}

class _AnimatedEducationCardState extends State<AnimatedEducationCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late VoidCallback _visibilityListener;

  // Hover effect scale
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // slide up
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Set up visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('Education')) {
        Future.delayed(Duration(milliseconds: widget.delay), () {
          if (mounted && !_controller.isAnimating && !_controller.isCompleted) {
            _controller.forward();
          }
        });
      } else {
        // Reset animation when not visible
        if (_controller.isCompleted) {
          _controller.reset();
        }
      }
    };

    // Add listener for this screen
    ScreenVisibilityNotifier.instance.addListener(
      'Education',
      _visibilityListener,
    );

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('Education')) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'Education',
      _visibilityListener,
    );
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: educationCard(
              title: widget.title,
              subtitle: widget.subtitle,
              date: widget.date,
            ),
          ),
        ),
      ),
    );
  }
}
