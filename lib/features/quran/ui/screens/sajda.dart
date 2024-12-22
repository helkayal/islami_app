import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../../data/models/quran_model.dart';
import '../controller/sajda_cubit/sajda_surahs_cubit.dart';
import '../widgets/surah_item.dart';
import 'sajda_ayas.dart';

class SajdaScreen extends StatefulWidget {
  const SajdaScreen({super.key});

  @override
  State<SajdaScreen> createState() => _SajdaScreenState();
}

class _SajdaScreenState extends State<SajdaScreen> {
  @override
  void initState() {
    BlocProvider.of<SajdaSurahsCubit>(context).getSajdaSurahs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SajdaSurahsCubit, SajdaSurahsState>(
      builder: (context, state) {
        if (state is SajdaSurahsLoading) {
          return Center(
            heightFactor: 10,
            child: LoadingAnimationWidget.inkDrop(
              color: AppColors.textColor,
              size: 50,
            ),
          );
        } else if (state is SajdaSurahsLoaded) {
          final List<QuranModel> surahs = state.surahs;
          return GrdientContainer(
            child: ListView.separated(
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding,
                    horizontal: AppConstants.defaultPadding,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SajdaAyas(
                            surahNumber: surahs[index].number!,
                            surahName: surahs[index].name!,
                          ),
                        ),
                      );
                    },
                    child: SurahItem(
                      quranModel: surahs[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.lightGrey,
                thickness: 2,
              ),
            ),
          );
        } else if (state is SajdaSurahsError) {
          return Center(
            child: Text(
              'Error: ${state.errMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(child: Text('Something went wrong.'));
      },
    );
  }
}
