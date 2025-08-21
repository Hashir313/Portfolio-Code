import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../sections/sections_screen.dart';

import 'widget/experience_card.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late VoidCallback _visibilityListener;

  @override
  void initState() {
    super.initState();

    // Fade animation for svg image
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Set up visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('Experience')) {
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
      'Experience',
      _visibilityListener,
    );

    // Check if already visible and start animation
    if (ScreenVisibilityNotifier.instance.isVisible('Experience')) {
      _fadeController.forward();
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'Experience',
      _visibilityListener,
    );
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.sizeOf(context).width < 600;

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
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: SvgPicture.asset(
                      'assets/experience.svg',
                      width: 80.w,
                      height: 30.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                _buildExperienceContent(isMobile),
              ],
            );
          } else {
            // Larger screen
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FadeTransition(
                      opacity: _fadeController,
                      child: SvgPicture.asset(
                        'assets/experience.svg',
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(child: _buildExperienceContent(isMobile)),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildExperienceContent(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          'Experience',
          textAlign: isMobile ? TextAlign.start : TextAlign.end,
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5.h),

        // Animated cards
        AnimatedExperienceCard(
          title:
              'Career Break (Pursuing Master\'s at ESCE Business School, Paris)',
          subtitle: 'ESCE, Paris, France',
          date: '2025 - Present',
          delay: 300,
        ),
        SizedBox(height: 2.h),
        AnimatedExperienceCard(
          title: 'Finance Associate',
          subtitle: 'Dexter Consultants, Islamabad, Pakistan',
          date: '2023 – 2024',
          delay: 600,
        ),
        SizedBox(height: 2.h),
        AnimatedExperienceCard(
          title: 'Junior Audit Associate',
          subtitle:
              'Qasim Adeel and Co. (Chartered Accountants), Islamabad, Pakistan',
          date: '2022 – 2023',
          delay: 900,
        ),
        SizedBox(height: 2.h),
        AnimatedExperienceCard(
          title: 'Internship Trainee',
          subtitle:
              'Qasim Adeel and Co. (Chartered Accountants), Islamabad, Pakistan',
          date: '2022 (Jul – Sep)',
          delay: 1200,
        ),
      ],
    );
  }
}

/// Custom animated card with fade, slide + hover effect
class AnimatedExperienceCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String date;
  final int delay;

  const AnimatedExperienceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.delay = 0,
  });

  @override
  State<AnimatedExperienceCard> createState() => _AnimatedExperienceCardState();
}

class _AnimatedExperienceCardState extends State<AnimatedExperienceCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late VoidCallback _visibilityListener;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // slide up
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Visibility listener
    _visibilityListener = () {
      if (ScreenVisibilityNotifier.instance.isVisible('Experience')) {
        Future.delayed(Duration(milliseconds: widget.delay), () {
          if (mounted && !_controller.isAnimating && !_controller.isCompleted) {
            _controller.forward();
          }
        });
      } else {
        if (_controller.isCompleted) {
          _controller.reset();
        }
      }
    };

    ScreenVisibilityNotifier.instance.addListener(
      'Experience',
      _visibilityListener,
    );

    if (ScreenVisibilityNotifier.instance.isVisible('Experience')) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    ScreenVisibilityNotifier.instance.removeListener(
      'Experience',
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: experienceCard(
                title: widget.title,
                subtitle: widget.subtitle,
                date: widget.date,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
