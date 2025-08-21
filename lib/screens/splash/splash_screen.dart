import 'package:flutter/material.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../portfolio_page/portfolio_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //! after splash screen, navigate to home screen
  void _navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context.mounted ? context : context,
        MaterialPageRoute(builder: (_) => PortfolioPage()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: LoadingAnimationWidget.inkDrop(color: primaryColor, size: 20.sp),
      ),
    );
  }
}
