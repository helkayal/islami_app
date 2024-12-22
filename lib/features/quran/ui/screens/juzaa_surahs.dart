import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/data/models/quran_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../controller/juzaa_cubit/juzaa_surahs_cubit.dart';
import '../widgets/surah_item.dart';
import 'juzaa_surah_ayas.dart';
// import 'juzaa_surah_ayas.dart';

class JuzaaSurahsScreen extends StatefulWidget {
  final int juzaaNumber;
  final String juzaaName;

  const JuzaaSurahsScreen({
    super.key,
    required this.juzaaNumber,
    required this.juzaaName,
  });

  @override
  State<JuzaaSurahsScreen> createState() => _JuzaaSurahsScreenState();
}

class _JuzaaSurahsScreenState extends State<JuzaaSurahsScreen> {
  @override
  void initState() {
    BlocProvider.of<JuzaaSurahsCubit>(context)
        .getJuzaaSurahs(widget.juzaaNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.juzaaName),
      ),
      body: BlocBuilder<JuzaaSurahsCubit, JuzaaSurahsState>(
        builder: (context, state) {
          if (state is JuzaaSurahsLoading) {
            return Center(
              child: Center(
                heightFactor: 10,
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.textColor,
                  size: 50,
                ),
              ),
            );
          } else if (state is JuzaaSurahsLoaded) {
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
                            builder: (context) => JuzaaSurahAyasScreen(
                              juzaaNumber: widget.juzaaNumber,
                              surahNumber: surahs[index].number!,
                              surahId: index,
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
          } else if (state is JuzaaSurahsError) {
            return Center(
              child: Text(
                'Error: ${state.errMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}

// class JuzaaSurahsScreen extends StatelessWidget {
//   final int juzaaNumber;

//   const JuzaaSurahsScreen({super.key, required this.juzaaNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Surahs in Juzaa $juzaaNumber')),
//       body: BlocBuilder<JuzaaSurahsCubit, JuzaaSurahsState>(
//         builder: (context, state) {
//           final List<QuranModel> surahs = state.surahs;
//           return ListView.separated(
//             itemBuilder: (context, index) {
//               final juzaaSurah = surahs[index];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: AppConstants.defaultPadding,
//                 ),
//                 child: InkWell(
//                   onTap: () {},
//                   child: SurahItem(
//                     quranModel: juzaaSurah,
//                   ),
//                 ),
//               );
//             },
//             separatorBuilder: (context, index) => const Divider(
//               color: AppColors.lightGrey,
//               thickness: 2,
//             ),
//             itemCount: surahs.length,
//           );
//         },
//       ),
//     );
//   }
// }
