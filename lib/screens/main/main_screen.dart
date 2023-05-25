import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/global/services/auth_service.dart';
import 'package:admin/requests/presentations/screens/requests_Screen.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../ambulance/presentation/screen/ambulance_screen.dart';
import '../../driver/presentation/screen/driver_screen.dart';

import '../../global/logic/cubits/screens_handler/screens_handler_cubit.dart';
import '../../hospitalemployee/presentation/screen/hospital-employee-screen.dart';
import '../../requests/data/models/ambulance_request.dart';
import '../../requests/logic/requests_handler/requests_handler_cubit.dart';
import '../admins/admins_screen.dart';
import 'components/side_menu.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  List<Widget> screens = [
    RequestsScreen(),
    HospitalEmployeeScreen(),
    DriverScreen(),
    AmbulanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestsHandlerCubit, RequestsHandlerState>(
      listener: (context, state) {
        if (state.requests != null && state.requests!.isNotEmpty) {
          final emergencyRequests = state.requests!.where((element) =>
              element.status == AmbulanceRequestStatus.pending &&
              element.type == AmbulanceRequestType.emergency);
          if (emergencyRequests.isNotEmpty) {
            for (var request in emergencyRequests) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      children: [
                        //get data from user which is\
                        //1. amulance id
                        //2. set the hospital id
                        Text('Emergency Request'),
                        Text('id: ${request.id}'),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<RequestsHandlerCubit>(context)
                                .acceptRequest(
                                    request.id!,
                                    'cA3DwLyRnfUV6hRpm0SK',
                                    RepositoryProvider.of<AuthService>(context)
                                        .user!
                                        .hospitalId!);
                            Navigator.pop(context);
                          },
                          child: Text('Accept'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<RequestsHandlerCubit>(context)
                                .cancelRequest(request.id!);
                            Navigator.pop(context);
                          },
                          child: Text('Decline'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        }
      },
      child: BlocBuilder<ScreenHandlerCubit, ScreenHandlerState>(
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
      ),
    );
  }
}
// }
