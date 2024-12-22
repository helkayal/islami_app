import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../../data/models/surah_details_model.dart';
import '../controller/sajda_cubit/sajda_ayas_cubit.dart';
import '../widgets/basmalla_container.dart';
import '../widgets/surah_detail_item.dart';

class SajdaAyas extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const SajdaAyas(
      {super.key, required this.surahNumber, required this.surahName});

  @override
  State<SajdaAyas> createState() => _SajdaAyasState();
}

class _SajdaAyasState extends State<SajdaAyas> {
  @override
  void initState() {
    BlocProvider.of<SajdaAyasCubit>(context).getJSajdaAyas(
      widget.surahNumber,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
      ),
      body: BlocBuilder<SajdaAyasCubit, SajdaAyasState>(
        builder: (context, state) {
          if (state is SajdaAyasLoading) {
            return Center(
              heightFactor: 10,
              child: Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.textColor,
                  size: 50,
                ),
              ),
            );
          } else if (state is SajdaAyasLoaded) {
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
          } else if (state is SajdaAyasError) {
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
