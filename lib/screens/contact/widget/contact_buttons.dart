import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  final IconData? icon; // agar icon use karna ho
  final String value; // actual contact text (email/phone/location)
  final ContactType type; // kis type ka hai
  final Color backgroundColor;

  const ContactRow({
    super.key,
    this.icon,
    required this.value,
    required this.type,
    required this.backgroundColor,
  });

  Future<void> _handleTap() async {
    Uri uri;
    switch (type) {
      case ContactType.email:
        uri = Uri(scheme: 'mailto', path: value);
        break;
      case ContactType.phone:
        uri = Uri(scheme: 'tel', path: value);
        break;
      case ContactType.location:
        uri = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$value",
        );
        break;
      case ContactType.link:
        uri = Uri.parse(value);
        break;
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(icon, color: secondaryColor, size: 15.sp),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

enum ContactType { email, phone, location, link }
