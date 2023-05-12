import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../screens/dashboard/components/header.dart';

class ScreensUITemplete extends StatelessWidget {
  const ScreensUITemplete({
    Key? key,
    required this.widgets,
    required this.title,
    this.onSearchChanged,
  }) : super(key: key);
  final List<Widget> widgets;
  final String title;
  final Function? onSearchChanged;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: title,
              onSearchChanged: onSearchChanged,
            ),
            SizedBox(height: defaultPadding),
            ...widgets,
          ],
        ),
      ),
    );
  }
}
