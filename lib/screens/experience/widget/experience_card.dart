import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../theme/colors.dart';

Widget experienceCard({
  required String title,
  required String subtitle,
  required String date,
}) {
  return SizedBox(
    width: double.infinity,
    child: Card(
      color: primaryColor.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: Icon(
                FontAwesomeIcons.briefcase,
                color: whiteColor,
                size: 2.w,
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 13.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
