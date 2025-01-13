import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../controller/azkar_cubit/azkar_cubit.dart';
import '../controller/azkar_cubit/azkar_states.dart';
import '../widgets/azkar_item.dart';

class AzkarScreen extends StatelessWidget {
  static const routeName = 'azkar_screen';
  final String title;
  const AzkarScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgetsAppBar(
        title: title,
      ),
      body: BlocBuilder<AzkarCubit, AzkarState?>(
        builder: (context, state) {
          if (state is AzkarLoading) {
            return Center(
              heightFactor: 10,
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.textColor,
                size: 50,
              ),
            );
          } else if (state is AzkarLoaded) {
            return GrdientContainer(
              child: ListView.separated(
                itemCount: state.azkar.length,
                itemBuilder: (context, index) {
                  final azkar = state.azkar[index];
                  return AzkarItem(
                    zkr: azkar.text,
                    count: azkar.count,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.lightGrey,
                  thickness: 2,
                ),
              ),
            );
          } else if (state is AzkarError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
