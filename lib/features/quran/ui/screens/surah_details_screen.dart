import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/surah_details_cubit/surah_details_cubit.dart';
import '../widgets/basmalla_container.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/surah_details_list.dart';
import '../widgets/surah_list.dart';
import '../../data/models/quran_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});
  static const routeName = 'sura_details_screen';

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late List<QuranModel> surahs;
  int selectedSurahIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    surahs = args[0] as List<QuranModel>;
    selectedSurahIndex = args[1] as int;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9E5FF),
        appBar: CustomAppBar(
          surahs: surahs,
          selectedSurahIndex: selectedSurahIndex,
        ),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            SurahsList(
              surahs: surahs,
              selectedSurahIndex: selectedSurahIndex,
              onSurahTap: (index) {
                setState(() {
                  selectedSurahIndex = index;
                  args[1] = index;
                });
                BlocProvider.of<SurahDetailsCubit>(context)
                    .getSurahDetails(index + 1); // Fetch Ayat for the Surah
              },
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: selectedSurahIndex != 8
                          ? const BasmallaContainer()
                          : const SizedBox.shrink(),
                    ),
                  ),
                  SurahDetailsList(
                    surahIndex: selectedSurahIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
