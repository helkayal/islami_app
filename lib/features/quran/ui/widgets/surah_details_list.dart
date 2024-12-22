import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/custom_error_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/surah_details_cubit/surah_details_cubit.dart';
import 'surah_detail_item.dart';

class SurahDetailsList extends StatefulWidget {
  const SurahDetailsList({
    super.key,
    required this.surahIndex,
  });
  final int surahIndex;

  @override
  State<SurahDetailsList> createState() => _SurahDetailsListState();
}

class _SurahDetailsListState extends State<SurahDetailsList> {
  @override
  void initState() {
    BlocProvider.of<SurahDetailsCubit>(context).getSurahDetails(
      widget.surahIndex + 1, // 1-based index
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahDetailsCubit, SurahDetailsState>(
      builder: (context, state) {
        if (state is SurahDetailsLoaded) {
          return SliverList.separated(
            itemBuilder: (context, index) => SurahDetailsItem(
              data: state.surahDetailsModel.ayahs[index],
              index: widget.surahIndex + 1,
            ),
            itemCount: state.surahDetailsModel.numberOfAyahs,
            separatorBuilder: (context, index) => const Divider(
              indent: 12,
              endIndent: 12,
            ),
          );
        } else if (state is SurahDetailsError) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(error: state.errMessage),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(
              heightFactor: 10,
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.textColor,
                size: 50,
              ),
            ),
          );
        }
      },
    );
  }
}
