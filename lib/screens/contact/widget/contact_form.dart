import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget contactTextField({
  required String labelText,
  required String hintText,
  required Color primaryColor,
  required TextEditingController? controller,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: GoogleFonts.poppins(
        color: primaryColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.sp),
      contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.w),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.sp),
        borderSide: BorderSide(
          color: primaryColor,
          width: 0.3.w, // responsive width
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: primaryColor, width: 0.3.w),
      ),
    ),
    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp),
  );
}
