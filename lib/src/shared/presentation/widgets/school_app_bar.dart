import 'package:flutter/material.dart';

class SchoolAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  const SchoolAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        child: title,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.orange.shade400,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
