import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/global/services/auth_service.dart';
import 'package:admin/requests/presentations/screens/requests_Screen.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

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
            // old
            // for (var request in emergencyRequests) {
            //   showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         content: Column(
            //           children: [
            //             //get data from user which is\
            //             //1. amulance id
            //             //2. set the hospital id
            //             Text('Emergency Request'),
            //             Text('id: ${request.id}'),
            //             ElevatedButton(
            //               onPressed: () {
            //                 BlocProvider.of<RequestsHandlerCubit>(context)
            //                     .acceptRequest(
            //                         request.id!,
            //                         'cA3DwLyRnfUV6hRpm0SK',
            //                         RepositoryProvider.of<AuthService>(context)
            //                             .user!
            //                             .hospitalId!);
            //                 Navigator.pop(context);
            //               },
            //               child: Text('Accept'),
            //             ),
            //             ElevatedButton(
            //               onPressed: () {
            //                 BlocProvider.of<RequestsHandlerCubit>(context)
            //                     .cancelRequest(request.id!);
            //                 Navigator.pop(context);
            //               },
            //               child: Text('Decline'),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   );
            // }
            // secondly way
            print(emergencyRequests.length);
            for (var request in emergencyRequests) {
              dailog = showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Emergency Request"),
                  content: Column(children: [
                    Text('Number of Request: ${request.id}'),
                    Text('Location of Request: ${request.sourceLocation}'),
                    Text('This Request Created at: ${request.createdAt}'),
                    Text('This Request Created at: ${request.caseDetails}'),
                  ]),
                  actions: [
                    ElevatedButton(
                      child: Text("Decline Request",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        BlocProvider.of<RequestsHandlerCubit>(context)
                            .cancelRequest(request.id!);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text("Accept Request",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        BlocProvider.of<RequestsHandlerCubit>(context)
                            .acceptRequest(
                          request.id!,
                          'cA3DwLyRnfUV6hRpm0SK', // get the ambulance id from the user
                          RepositoryProvider.of<AuthService>(context)
                              .user!
                              .hospitalId!,
                        );
                        Navigator.of(context).pop();
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

// فقدت الامل فيها
//third way with package but i delete it
// bool alertShown = false;
//           for (var request in emergencyRequests) {
//             if (!alertShown) {
//               var alert = Alert(
//                 context: context,
//                 type: AlertType.warning,
//                 title: "Emergency Request",
//                 desc:
//                     "This is emergency request, Please accept or decline request in few minutes to save our Patient",
//                 content: Column(children: [
//                   Text('Number of Request: ${request.id}'),
//                   Text('Location of Request: ${request.sourceLocation}'),
//                   Text('This Request Created at: ${request.sourceLocation}'),
//                   Text('This Request Created at: ${request.caseDetails}'),
//                 ]),
//                 buttons: [
//                   DialogButton(
//                     child: Text("Decline Request",
//                         style: TextStyle(color: Colors.white, fontSize: 18)),
//                     onPressed: () {
//                       BlocProvider.of<RequestsHandlerCubit>(context)
//                           .cancelRequest(request.id!);
//                       Navigator.of(context, rootNavigator: true).pop();
//                     },
//                     color: Color.fromRGBO(92, 92, 92, 1),
//                   ),
//                   DialogButton(
//                     child: Text("Accept Request",
//                         style: TextStyle(color: Colors.white, fontSize: 18)),
//                     onPressed: () {
//                       BlocProvider.of<RequestsHandlerCubit>(context)
//                           .acceptRequest(
//                         request.id!,
//                         'cA3DwLyRnfUV6hRpm0SK',
//                         RepositoryProvider.of<AuthService>(context)
//                             .user!
//                             .hospitalId!,
//                       );
//                       Navigator.of(context).pop();
//                     },
//                     color: Color.fromRGBO(0, 179, 134, 1.0),
//                   ),
//                 ],
//               );
//               alert.show();
//               alertShown = true;
//             }
//             break;
//           }
