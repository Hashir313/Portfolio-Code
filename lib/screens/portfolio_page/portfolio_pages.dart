import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../theme/colors.dart';
import '../sections/sections_screen.dart';

final isBlurredProvider = StateProvider<bool>((ref) => false);

class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final educationKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpen) {
        ref.read(isBlurredProvider.notifier).state = isOpen;
        if (!isOpen) {
          _scrollController.animateTo(
            0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          ref.read(isBlurredProvider.notifier).state = false;
        }
      },
      drawer: Consumer(
        builder: (context, ref, _) => Drawer(
          backgroundColor: secondaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top-right close button
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: primaryColor, size: 18.sp),
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(isBlurredProvider.notifier).state = false;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5.h),

                // Navigation buttons
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                    child: ListView(
                      children: [
                        ListTile(
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.sp),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          title: Text(
                            'Home',
                            style: GoogleFonts.poppins(
                              fontSize: 13.0.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            Icons.home,
                            color: primaryColor,
                            size: 17.sp,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _scrollToSection(homeKey);
                          },
                        ),
                        SizedBox(height: 5.h),
                        ListTile(
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.sp),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          title: Text(
                            'About',
                            style: GoogleFonts.poppins(
                              fontSize: 13.0.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            Icons.person,
                            color: primaryColor,
                            size: 17.sp,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _scrollToSection(aboutKey);
                          },
                        ),
                        SizedBox(height: 5.h),
                        ListTile(
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.sp),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          title: Text(
                            'Education',
                            style: GoogleFonts.poppins(
                              fontSize: 13.0.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.graduationCap,
                            color: primaryColor,
                            size: 17.sp,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _scrollToSection(educationKey);
                          },
                        ),
                        SizedBox(height: 5.h),
                        ListTile(
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.sp),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          title: Text(
                            'Skills',
                            style: GoogleFonts.poppins(
                              fontSize: 13.0.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.brain,
                            color: primaryColor,
                            size: 17.sp,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _scrollToSection(skillsKey);
                          },
                        ),
                        SizedBox(height: 5.h),
                        ListTile(
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.sp),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          title: Text(
                            'Experience',
                            style: GoogleFonts.poppins(
                              fontSize: 12.0.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.briefcase,
                            color: primaryColor,
                            size: 17.sp,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _scrollToSection(experienceKey);
                          },
                        ),

                        SizedBox(height: 5.h),
                        ListTile(
                          textColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.sp),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          title: Text(
                            'Contact',
                            style: GoogleFonts.poppins(
                              fontSize: 13.0.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            Icons.phone,
                            color: primaryColor,
                            size: 17.sp,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _scrollToSection(contactKey);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) => Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SectionWidget(
                    key: homeKey,
                    title: 'Home',
                    color: Colors.orange,
                  ),
                  SectionWidget(
                    key: aboutKey,
                    title: 'About',
                    color: Colors.blue,
                  ),
                  SectionWidget(
                    key: educationKey,
                    title: 'Education',
                    color: Colors.green,
                  ),
                  SectionWidget(
                    key: skillsKey,
                    title: 'Skills',
                    color: Colors.green,
                  ),
                  SectionWidget(
                    key: experienceKey,
                    title: 'Experience',
                    color: Colors.green,
                  ),
                  SectionWidget(
                    key: contactKey,
                    title: 'Contact',
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            // Blur overlay (conditionally visible)
            Consumer(
              builder: (context, ref, _) {
                final isBlurred = ref.watch(isBlurredProvider);
                return isBlurred
                    ? Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withValues(
                              alpha: 0.2,
                            ), // optional dark tint
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
