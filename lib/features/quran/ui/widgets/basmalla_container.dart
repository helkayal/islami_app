import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theming/colors.dart';

class BasmallaContainer extends StatelessWidget {
  const BasmallaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight * 0.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xff9466B1),
            Color(0xff3D4DD8),
          ],
        ),
      ),
      child: Center(
        child: Text(
          'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
          style: GoogleFonts.amiri(
            fontSize: 28.sp,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
