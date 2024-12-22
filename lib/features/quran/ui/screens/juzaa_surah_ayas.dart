import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../../data/models/surah_details_model.dart';
import '../controller/juzaa_cubit/surah_ayas_cubit.dart';
import '../widgets/basmalla_container.dart';
import '../widgets/surah_detail_item.dart';

class JuzaaSurahAyasScreen extends StatefulWidget {
  final int juzaaNumber;
  final int surahNumber;
  final int surahId;
  final String surahName;

  const JuzaaSurahAyasScreen({
    super.key,
    required this.juzaaNumber,
    required this.surahNumber,
    required this.surahId,
    required this.surahName,
  });

  @override
  State<JuzaaSurahAyasScreen> createState() => _JuzaaSurahAyasScreenState();
}

class _JuzaaSurahAyasScreenState extends State<JuzaaSurahAyasScreen> {
  @override
  void initState() {
    BlocProvider.of<SurahAyasCubit>(context)
        .getJSurahAyas(widget.juzaaNumber, widget.surahNumber, widget.surahId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
      ),
      body: BlocBuilder<SurahAyasCubit, SurahAyasState>(
        builder: (context, state) {
          if (state is SurahAyasLoading) {
            return Center(
              child: Center(
                heightFactor: 10,
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.textColor,
                  size: 50,
                ),
              ),
            );
          } else if (state is SurahAyasLoaded) {
            final List<Ayah> ayas = state.ayas;
            return GrdientContainer(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding * 1.5,
                        vertical: AppConstants.defaultPadding),
                    child: widget.surahNumber != 9
                        ? const BasmallaContainer()
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: ayas.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.defaultPadding,
                            horizontal: AppConstants.defaultPadding,
                          ),
                          child: SurahDetailsItem(
                            data: ayas[index],
                            index: widget.surahNumber,
                          ),
                          // Text(
                          //   ayas[index].text,
                          //   style:
                          //       Theme.of(context).textTheme.headlineSmall!.copyWith(
                          //             color: AppColors.textColor,
                          //           ),
                          // ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.lightGrey,
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SurahAyasError) {
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
