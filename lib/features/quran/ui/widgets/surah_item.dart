import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami_app/features/quran/data/models/quran_model.dart';

import '../../../../core/theming/colors.dart';

class SurahItem extends StatelessWidget {
  const SurahItem({super.key, required this.quranModel});
  final QuranModel quranModel;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/images/Star 1.png"),
            radius: 22.r,
            child: Text(
              quranModel.number.toString(),
              style: GoogleFonts.amiri(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quranModel.englishName.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${quranModel.revelationType} - ',
                    style: GoogleFonts.poppins(
                      color: const Color(0xffA4A3A6),
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    '${quranModel.numberOfAyahs} Ayat',
                    style: GoogleFonts.poppins(
                      color: const Color(0xffA4A3A6),
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            '${quranModel.name}',
            style: GoogleFonts.amiri(
              fontSize: 24.sp,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
