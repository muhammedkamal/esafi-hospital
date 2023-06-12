
import 'package:flutter/material.dart';
import '../../global/presentation/templets/main_ui_templete.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Admins',
      widgets: [
       
      ],
    );
  }
}
