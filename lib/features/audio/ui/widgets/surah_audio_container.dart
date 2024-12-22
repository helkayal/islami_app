import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theming/colors.dart';
import '../../../quran/data/models/quran_model.dart';

class SurahAudioContainer extends StatelessWidget {
  const SurahAudioContainer({super.key, required this.surah});
  final QuranModel surah;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight * 0.16,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xff9466B1),
            Color(0xff3D4DD8),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'سورة ${surah.name!}',
            style: GoogleFonts.amiri(
              fontSize: 28.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Total Ayat : ${surah.numberOfAyahs}',
            style: GoogleFonts.amiri(
              fontSize: 28.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
