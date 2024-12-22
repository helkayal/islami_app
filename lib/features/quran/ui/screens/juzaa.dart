import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../data/models/juzaa_model.dart';
import '../controller/juzaa_cubit/juzaa_cubit.dart';
import 'juzaa_surahs.dart';

class JuzaaScreen extends StatefulWidget {
  const JuzaaScreen({super.key});

  @override
  State<JuzaaScreen> createState() => _JuzaaScreenState();
}

class _JuzaaScreenState extends State<JuzaaScreen> {
  @override
  void initState() {
    BlocProvider.of<JuzaaCubit>(context).getJuzaas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JuzaaCubit, JuzaaState>(
      builder: (context, state) {
        if (state is JuzaaLoading) {
          return Center(
            child: Center(
              heightFactor: 10,
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.textColor,
                size: 50,
              ),
            ),
          );
        } else if (state is JuzaaLoaded) {
          final List<Juzaa> juzaas = state.juzaa;
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: AppConstants.defaultMargin * 4,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding * 3,
              ),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 30,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JuzaaSurahsScreen(
                          juzaaNumber: juzaas[index].number,
                          juzaaName: juzaas[index].name,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultMargin * .5,
                      vertical: AppConstants.defaultMargin * .5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkPurple.withAlpha(120),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.darkGrey,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.lightGrey,
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${juzaas[index].number}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is JuzaaError) {
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
