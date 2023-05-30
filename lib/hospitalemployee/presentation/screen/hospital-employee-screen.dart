// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../constants.dart';
// import '../../../global/presentation/components/table_container.dart';
// import '../../../global/presentation/templets/main_ui_templete.dart';
// import '../../logic/block/hospital-employe-block.dart';
// import '../../logic/block/hospital-employe-event.dart';
// import '../../logic/block/hospital-employe-state.dart';
// import 'single-employee-screen.dart';

// class HospitalEmployeeScreen extends StatelessWidget {
//   const HospitalEmployeeScreen ({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScreensUITemplete(
//       onSearchChanged: (value) {
//         print(value);
//       },
//       title: "Hospital Employee",
//       widgets: [
//         BlocBuilder<HospitalEmployeeBloc , HospitalEmployeeState>(
//           builder: (context, state) {
//             if (state is HospitalEmployeeInitial) {
//               BlocProvider.of<HospitalEmployeeBloc>(context).add(LoadHospitalEmployee());
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is HospitalEmployeeLoading) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is HospitalEmployeeLoaded) {
//               print(state.hospitalemployee);
//               return TableContainer(
//                 title: "Hospital Employee",
//                 table: DataTable2(
//                     columnSpacing: defaultPadding,
//                     //minWidth: 600,
//                     columns: [
//                       DataColumn(
//                         label: Text(" ID "),
//                       ),
//                       DataColumn(
//                         label: Text(" Name "),
//                       ),
//                       DataColumn(
//                         label: Text(" Phone Number "),
//                       ),
//                       DataColumn(
//                         label: Text("email"),
//                       ),
//                       DataColumn(
//                         label: Text("Hospital ID"),
//                       ),
//                     ],
//                     rows: List.generate(
//                       state.hospitalemployee.length,
//                       (index) => DataRow(
//                         cells: [
//                           DataCell(Text(state.hospitalemployee[index].id)),
//                           DataCell(Text(state.hospitalemployee[index].name)),
//                           DataCell(Text(state.hospitalemployee[index].phoneNumber)),
//                           DataCell(Text(state.hospitalemployee[index].email)),
//                           DataCell(Text(state.hospitalemployee[index].hospitalId)),
//                           DataCell(
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.remove_red_eye,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             SingleEmployeeScreen(
//                                           hopitalemployee: state.hospitalemployee[index],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.delete,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (_) => AlertDialog(
//                                         title: Text('Delete video'),
//                                         content: Text(
//                                             'Are you sure you want to delete this user?'),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text('Cancel'),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               BlocProvider.of<HospitalEmployeeBloc>(
//                                                       context)
//                                                   .add(DeleteHospitalEmployee(state
//                                                       .hospitalemployee[index].id));
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text('Delete'),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//               );
//             }
//             return Placeholder();
//           },
//         )
//       ],
//     );
//   }
// }
import 'package:admin/global/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../global/logic/cubits/hospital/single_hospital_cubit.dart';
import '../../../global/logic/providers/hospital_provider.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';

class HospitalEmployeeScreen extends StatefulWidget {
  const HospitalEmployeeScreen({Key? key}) : super(key: key);
  @override
  State<HospitalEmployeeScreen> createState() => _SingleHospitalState();
}

class _SingleHospitalState extends State<HospitalEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Hospital Employee',
      widgets: [
        BlocBuilder<SingleHospitalCubit, SingleHospitalState>(
          builder: (context, state) {
            // if (state.hospital == null) {
            //   print(
            //       RepositoryProvider.of<AuthService>(context).user?.hospitalId);
            //   BlocProvider.of<SingleHospitalCubit>(context).getHospital(
            //       RepositoryProvider.of<AuthService>(context)
            //           .user!
            //           .hospitalId!);
            // }
            // print(state.hospital);
            return state.hospital == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : TableContainer(
                    headerTrailing: ElevatedButton.icon(
                      onPressed: () {
                        BlocProvider.of<SingleHospitalCubit>(context)
                            .addHospitalEmployee({
                          "hospitalId": state.hospital!.id,
                          "email": "ts@rt.bg",
                          "password": "12345678",
                          "phoneNumber": "12345678",
                          "name": "test",
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Employee"),
                    ),
                    title: 'Hospital Employee',
                    table: DataTable(
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text('ID'),
                        ),
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Email'),
                        ),
                        DataColumn(
                          label: Text('Phone Number'),
                        ),
                        DataColumn(
                          label: Text(
                            'Hospital ID',
                            maxLines: 2,
                          ),
                        ),
                        DataColumn(
                          label: Text('Actions'),
                        ),
                      ],
                      rows: List.generate(
                        state.hospital!.employees!.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                                Text(state.hospital!.employees![index].id)),
                            DataCell(
                              Text(
                                state.hospital!.employees![index].name,
                              ),
                            ),
                            DataCell(
                              Text(
                                state.hospital!.employees![index].email,
                              ),
                            ),
                            DataCell(
                              Text(
                                state.hospital!.employees![index].phoneNumber ??
                                    "-",
                              ),
                            ),
                            DataCell(
                              Text(
                                  state.hospital!.employees![index].hospitalId),
                            ),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    // data['Position'] = value;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Add New Employee'),
                                          content: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'ID'),
                                                  onChanged: (value) {
                                                    data['ID'] = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Name'),
                                                  onChanged: (value) {
                                                    data['Name'] = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Email'),
                                                  onChanged: (value) {
                                                    data['Email'] = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          'Phone Number'),
                                                  onChanged: (value) {
                                                    data['Phone Number'] =
                                                        value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Hospital ID'),
                                                  onChanged: (value) {
                                                    data['Hospital ID'] = value;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                // add admin to hospital
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Add'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
