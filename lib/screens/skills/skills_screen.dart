import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/screens/skills/widget/auto_scroll_row.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Column(
          children: [
            Text(
              'Skills',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            AutoScrollCards(),
          ],
        ),
      ),
    );
  }
}
