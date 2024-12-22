import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool isCenterTitle;
  final bool allowBack;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.isCenterTitle = false,
      required this.allowBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: isCenterTitle,
      elevation: 0,
      automaticallyImplyLeading: allowBack,
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.bookmark),
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
