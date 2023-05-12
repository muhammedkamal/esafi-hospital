import 'package:admin/controllers/MenuAppController.dart';

import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../ambulance/presentation/screen/ambulance_screen.dart';
import '../../driver/presentation/screen/driver_screen.dart';

import '../../global/logic/cubits/screens_handler/screens_handler_cubit.dart';
import '../admins/admins_screen.dart';
import 'components/side_menu.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  List<Widget> screens = [
    DashboardScreen(),
    AdminScreen(),
    DriverScreen(),
    AmbulanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenHandlerCubit, ScreenHandlerState>(
      builder: (context, state) {
        return Scaffold(
          key: context.read<MenuAppController>().scaffoldKey,
          drawer: SideMenu(),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(),
                  ),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: screens[state.currentIndex],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// }
