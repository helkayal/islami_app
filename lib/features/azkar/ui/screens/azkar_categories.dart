import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../controller/azkar_categories_cubit/azkar_categories_cubit.dart';
import '../controller/azkar_categories_cubit/azkar_categories_states.dart';
import '../controller/azkar_cubit/azkar_cubit.dart';
import '../widgets/azkar_category_item.dart';
import '../widgets/custom_app_bar.dart';
import 'azkar_screen.dart';

class AzkarCategoriesScreen extends StatelessWidget {
  static const routeName = 'azkar_categories';

  const AzkarCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "الأذكـــار",
        ),
        body: BlocBuilder<AzkarCategoriesCubit, AzkarCategoriesState>(
          builder: (context, state) {
            if (state is AzkarCategoriesLoading) {
              return Center(
                heightFactor: 10,
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.textColor,
                  size: 50,
                ),
              );
            } else if (state is AzkarCategoriesLoaded) {
              final categories = state.azkarCategories;
              return GrdientContainer(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConstants.defaultPadding,
                      ),
                      child: Image.asset(
                        'assets/images/header.png',
                        width: ScreenUtil().screenWidth * .9,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.defaultPadding * 2,
                              horizontal: AppConstants.defaultPadding * 2,
                            ),
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<AzkarCubit>(context)
                                    .loadAzkarForCategory(
                                        categories[index].category);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AzkarScreen(
                                      title: categories[index].category,
                                    ),
                                  ),
                                );
                              },
                              child: AzkarCategoryItem(
                                  title: categories[index].category,
                                  index: index + 1),
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
            } else if (state is AzkarCategoriesError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "No data available",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
