import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/audio/ui/controller/recitation_cubit/recitation_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../controller/recitation_cubit/recitation_cubit.dart';
import 'recitation_item.dart';

class RecitationsListView extends StatelessWidget {
  const RecitationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecitationCubit, RecitationState>(
      builder: (context, state) {
        if (state is RecitationSuccess) {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInLeft(
                  child: RecitationsItem(
                    recitation: state.recitations[index + 1],
                  ),
                );
              },
              itemCount: state.recitations.length - 1,
            ),
          );
        } else if (state is RecitationFailure) {
          return CustomErrorWidget(error: state.errMessage);
        } else {
          return Center(
            heightFactor: 5.h,
            child: LoadingAnimationWidget.inkDrop(
              color: AppColors.textColor,
              size: 50.sp,
            ),
          );
        }
      },
    );
  }
}
