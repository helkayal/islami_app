import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami_app/core/theming/constants.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/grdient_container.dart';
import 'juzaa.dart';
import 'sajda.dart';
import 'sura.dart';
import '../widgets/bar_text.dart';

class QuranHomeScreen extends StatelessWidget {
  static const String routeName = 'quran_home';
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'القرآن الكريم',
            style: GoogleFonts.amiri(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Container(
              height: 45.h,
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultMargin * 2,
                vertical: AppConstants.defaultMargin * 2,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.defaultRadius * 3),
                ),
                color: AppColors.whiteColor,
              ),
              child: const TabBar(
                tabs: [
                  BarText(
                    text: "سورة",
                  ),
                  BarText(
                    text: "سجدة",
                  ),
                  BarText(
                    text: "جزء",
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const GrdientContainer(
          child: TabBarView(
            children: [
              SuraScreen(),
              SajdaScreen(),
              JuzaaScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
