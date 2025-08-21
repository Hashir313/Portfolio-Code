import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/screens/contact/widget/contact_form.dart';
import 'package:huzaifa_portfolio/screens/contact/widget/contact_buttons.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              "Contacts",
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),

            // Responsive layout
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600; // breakpoint

                  if (isMobile) {
                    // 📱 Mobile layout
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Form
                              Expanded(
                                flex: 2,
                                child: _buildFormSection(isMobile),
                              ),

                              SizedBox(width: 5.w),

                              // Image
                              Expanded(
                                flex: 1,
                                child: SvgPicture.asset(
                                  "assets/contacts.svg",
                                  width: 30.w,
                                  height: 30.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          _buildContactInfo(),
                        ],
                      ),
                    );
                  } else {
                    // 💻 Web / Tablet layout
                    return Row(
                      children: [
                        Expanded(flex: 2, child: _buildFormSection(isMobile)),
                        Expanded(
                          flex: 2,
                          child: Stack(
                            children: [
                              _buildContactInfo(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                  "assets/contacts.svg",
                                  width: 70.w,
                                  height: 70.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendEmail(String name, String email, String message) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'huzaifamasood333@gmail.com',
      query:
          'subject=Contact Form&body=Name: $name\nEmail: $email\nMessage: $message',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email app');
    }
  }

  /// Form section
  Widget _buildFormSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isMobile ? double.infinity : 25.w,
          child: contactTextField(
            controller: nameController,
            labelText: 'Name',
            primaryColor: primaryColor,
            hintText: 'Your Name',
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: isMobile ? double.infinity : 25.w,
          child: contactTextField(
            controller: emailController,
            labelText: 'Email',
            primaryColor: primaryColor,
            hintText: 'Your Email',
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: isMobile ? double.infinity : 25.w,
          child: contactTextField(
            controller: messageController,
            labelText: 'Message',
            primaryColor: primaryColor,
            hintText: 'Your Message',
            maxLines: 4,
          ),
        ),
        SizedBox(height: 4.h),

        // Submit Button
        SizedBox(
          width: isMobile ? double.infinity : 12.w,
          height: 7.h,
          child: InkWell(
            onTap: () {
              String name = nameController.text;
              String email = emailController.text;
              String message = messageController.text;
              if (kDebugMode) {
                print('Name: $name, Email: $email, Message: $message');
              }
              sendEmail(name, email, message);
            },
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Send",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: secondaryColor,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Transform.rotate(
                    angle: 20 * 3.1415926535 / 180,
                    child: Icon(
                      FontAwesomeIcons.paperPlane,
                      size: 15.sp,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Contact Info Section
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactRow(
          icon: FontAwesomeIcons.at,
          value: "huzaifamasood333@gmail.com",
          type: ContactType.email,
          backgroundColor: primaryColor,
        ),
        SizedBox(height: 4.h),
        ContactRow(
          icon: FontAwesomeIcons.phone,
          value: "+92 312 5114785",
          type: ContactType.phone,
          backgroundColor: primaryColor,
        ),
        SizedBox(height: 4.h),
        ContactRow(
          icon: FontAwesomeIcons.locationDot,
          value: "Paris, France",
          type: ContactType.location,
          backgroundColor: primaryColor,
        ),
      ],
    );
  }
}
