import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/quran_model.dart';
import 'custom_container.dart';

class SurahsList extends StatelessWidget {
  const SurahsList({
    super.key,
    required this.surahs,
    required this.selectedSurahIndex,
    required this.onSurahTap,
  });

  final List<QuranModel> surahs;
  final int selectedSurahIndex;
  final ValueChanged<int> onSurahTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: surahs.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: InkWell(
            onTap: () => onSurahTap(index),
            child: CustomContainer(
              quranModel: surahs[index],
              isSelected: index == selectedSurahIndex,
            ),
          ),
        ),
      ),
    );
  }
}
