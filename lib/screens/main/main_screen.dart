import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/global/services/auth_service.dart';
import 'package:admin/requests/presentations/screens/requests_Screen.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

import '../../ambulance/presentation/screen/ambulance_screen.dart';
import '../../driver/presentation/screen/driver_screen.dart';

import '../../global/logic/cubits/screens_handler/screens_handler_cubit.dart';
import '../../hospitalemployee/presentation/screen/hospital-employee-screen.dart';
import '../../requests/data/models/ambulance_request.dart';
import '../../requests/logic/requests_handler/requests_handler_cubit.dart';
import 'components/side_menu.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  List<Widget> screens = [
    RequestsScreen(),
    HospitalEmployeeScreen(),
    DriverScreen(),
    AmbulanceScreen(),
  ];
  var emergencyRequests;
  var dailog;

  @override
  Widget build(BuildContext context) {
    print("build");
    return BlocListener<RequestsHandlerCubit, RequestsHandlerState>(
      listener: (context, state) async {
        print("listen");

        if (state.requests != null &&
            state.requests!.isNotEmpty &&
            dailog == null &&
            emergencyRequests == null) {
          emergencyRequests = state.requests!.where((element) =>
              element.status == AmbulanceRequestStatus.pending &&
              element.type == AmbulanceRequestType.emergency);
          if (emergencyRequests.isNotEmpty) {
            print(emergencyRequests.length);

            for (var request in emergencyRequests) {
              if (dailog != null) {
                Navigator.of(context, rootNavigator: true).pop();
              }
              print("showing");
              dailog = showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Emergency Request"),
                  content: Column(
                    children: [
                      Image.asset(
                        'assets/images/emergency.png',
                        width: 200, // set the width of the image
                        height: 200,
                      ),
                      Text('Number of Request: ${request.id}'),
                      Text(
                          'Location of Request: ${request.destinationLocation}'),
                      Text('This Request Created at: ${request.createdAt}'),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text("Decline Request",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        BlocProvider.of<RequestsHandlerCubit>(context)
                            .cancelRequest(request.id!);
                        Navigator.of(context, rootNavigator: true).pop();
                        dailog = null;
                        emergencyRequests = null;
                      },
                    ),
                    ElevatedButton(
                      child: Text("Accept Request",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        TextEditingController ambulanceID =
                            TextEditingController();
                        Navigator.of(context, rootNavigator: true).pop();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Emergency Request"),
                            content: Column(
                              children: [
                                TextFormField(
                                  controller: ambulanceID,
                                )
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text("Accept Request",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                onPressed: () {
                                  BlocProvider.of<RequestsHandlerCubit>(context)
                                      .acceptRequest(
                                    request.id!,
                                    ambulanceID.text,
                                    RepositoryProvider.of<AuthService>(context)
                                        .user!
                                        .hospitalId!,
                                    emergency: true,
                                  );
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  dailog = null;
                                  emergencyRequests = null;
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
