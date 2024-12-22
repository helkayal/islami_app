import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/grdient_container.dart';

import '../controller/recitation_cubit/recitation_cubit.dart';
import '../widgets/recitation_list_view.dart';

class AudioScreen extends StatefulWidget {
  static const String routeName = 'audio';
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  void initState() {
    BlocProvider.of<RecitationCubit>(context).getRecitations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'الصوتيات',
        ),
        isCenterTitle: true,
        allowBack: true,
      ),
      body: GrdientContainer(
        child: Column(
          children: [
            RecitationsListView(),
          ],
        ),
      ),
    );
  }
}
