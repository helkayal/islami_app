import 'package:flutter/material.dart';

import '../../../../core/widgets/grdient_container.dart';
import '../widgets/home_view_body.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home';
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GrdientContainer(
        child: HomeScreenBody(),
      ),
    );
  }
}
