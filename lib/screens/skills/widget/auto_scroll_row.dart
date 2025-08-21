import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huzaifa_portfolio/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AutoScrollCards extends StatefulWidget {
  const AutoScrollCards({super.key});

  @override
  State<AutoScrollCards> createState() => _AutoScrollCardsState();
}

class _AutoScrollCardsState extends State<AutoScrollCards> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  bool _isHovered = false;

  // 🔹 Skills Data (Skill + Icon)
  final List<Map<String, dynamic>> skillsData = [
    {"caption": "Accounting Fundamentals", "icon": FontAwesomeIcons.calculator},
    {"caption": "IFRS", "icon": FontAwesomeIcons.fileInvoiceDollar},
    {
      "caption": "Reading Financial Statements",
      "icon": FontAwesomeIcons.fileLines,
    },
    {"caption": "Financial Statements", "icon": FontAwesomeIcons.fileContract},
    {"caption": "FBR", "icon": FontAwesomeIcons.landmark},
    {"caption": "SECP", "icon": FontAwesomeIcons.buildingColumns},
    {
      "caption": "Registration Services",
      "icon": FontAwesomeIcons.clipboardCheck,
    },
    {
      "caption": "Incorporation Services",
      "icon": FontAwesomeIcons.buildingUser,
    },
    {"caption": "Section 42", "icon": FontAwesomeIcons.handshakeAngle},
    {"caption": "Data Visualization", "icon": FontAwesomeIcons.chartBar},
    {"caption": "Reporting & Analysis", "icon": FontAwesomeIcons.chartPie},
    {"caption": "Data-driven Decisions", "icon": FontAwesomeIcons.lightbulb},
    {"caption": "Data Modeling", "icon": FontAwesomeIcons.diagramProject},
    {"caption": "Data Analysis", "icon": FontAwesomeIcons.chartLine},
    {"caption": "Microsoft 365", "icon": FontAwesomeIcons.windows},
    {"caption": "Data Entry", "icon": FontAwesomeIcons.keyboard},
    {"caption": "Bookkeeping Basics", "icon": FontAwesomeIcons.book},
    {"caption": "Microsoft Office", "icon": FontAwesomeIcons.fileWord},
    {"caption": "Finance", "icon": FontAwesomeIcons.sackDollar},
    {"caption": "Bank Reconciliation", "icon": FontAwesomeIcons.scaleBalanced},
    {"caption": "Financial Planning", "icon": FontAwesomeIcons.chartArea},
    {"caption": "NGOs", "icon": FontAwesomeIcons.users},
    {"caption": "PCP", "icon": FontAwesomeIcons.certificate},
    {"caption": "Income Tax", "icon": FontAwesomeIcons.receipt},
    {
      "caption": "Financial Accounting",
      "icon": FontAwesomeIcons.moneyCheckDollar,
    },
    {
      "caption": "Financial Audits",
      "icon": FontAwesomeIcons.magnifyingGlassDollar,
    },
    {"caption": "Bookkeeping", "icon": FontAwesomeIcons.bookOpen},
    {"caption": "Microsoft Excel", "icon": FontAwesomeIcons.fileExcel},
    {"caption": "Financial Analysis", "icon": FontAwesomeIcons.chartLine},
    {"caption": "QuickBooks", "icon": FontAwesomeIcons.laptopFile},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
      if (!_isHovered && _scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0); // loop reset
        } else {
          _scrollController.jumpTo(currentScroll + 1); // speed
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            height: 28.h,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skillsData.length * 1000, // infinite loop
              itemBuilder: (context, index) {
                final realIndex = index % skillsData.length;
                return SkillCard(
                  caption: skillsData[realIndex]["caption"] ?? "No Caption",
                  icon: skillsData[realIndex]["icon"] as IconData,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Custom Skill Card Widget with Hover Animation
class SkillCard extends StatefulWidget {
  final String caption;
  final IconData icon;

  const SkillCard({super.key, required this.caption, required this.icon});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // 🔹 Responsive values
    final bool isMobile = Device.screenType == ScreenType.mobile;
    final double cardWidth = isMobile ? 25.w : 10.w;
    final double iconSize = isMobile ? 28.sp : 20.sp;
    final double fontSize = isMobile ? 14.sp : 14.sp;
    final EdgeInsets margin = isMobile
        ? EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h)
        : EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: _hovering ? 1 : 0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          final scale = 1 + (0.07 * value);
          final tiltX = -0.05 * value;
          final tiltY = 0.05 * value;

          return Container(
            margin: margin,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..scale(scale)
                ..rotateX(tiltX)
                ..rotateY(tiltY),
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(
                        alpha: _hovering ? 0.55 : 0.3,
                      ),
                      blurRadius: _hovering ? 30 : 12,
                      spreadRadius: _hovering ? 6 : 3,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                width: cardWidth,
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(widget.icon, size: iconSize, color: primaryColor),
                      const SizedBox(height: 12),
                      Text(
                        widget.caption,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bigShouldersText(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
