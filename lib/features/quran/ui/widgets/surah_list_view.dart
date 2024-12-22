import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/ui/controller/surah_cubit/quran_cubit.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../screens/surah_details_screen.dart';
import 'surah_item.dart';

class SurahListView extends StatefulWidget {
  const SurahListView({super.key});

  @override
  State<SurahListView> createState() => _SurahListViewState();
}

class _SurahListViewState extends State<SurahListView> {
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).getSurahs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.defaultPadding,
        horizontal: AppConstants.defaultPadding * 2,
      ),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.defaultPadding,
                ),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    SuraDetailsScreen.routeName,
                    arguments: [state.surahs, index],
                  ),
                  child: SurahItem(
                    quranModel: state.surahs[index],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.lightGrey,
                thickness: 2,
              ),
              itemCount: 114,
            );
          } else if (state is QuranError) {
            return CustomErrorWidget(error: state.errMessage);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
