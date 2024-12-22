import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../quran/data/models/quran_model.dart';
import '../../../quran/ui/widgets/surah_item.dart';

class SurahAudioListView extends StatelessWidget {
  const SurahAudioListView({
    super.key,
    required this.surahs,
    required this.onSurahTap,
  });

  final List<QuranModel> surahs;
  final Function(int) onSurahTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.defaultPadding,
        ),
        child: InkWell(
          onTap: () => onSurahTap(index), // Trigger the callback with the index
          child: SurahItem(
            quranModel: surahs[index],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.lightGrey,
        thickness: 2,
      ),
      itemCount: surahs.length,
    );
  }
}
