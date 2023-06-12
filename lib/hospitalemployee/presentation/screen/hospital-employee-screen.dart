import 'package:admin/hospitalemployee/logic/block/hospital-employe-event.dart';
import 'package:admin/hospitalemployee/presentation/screen/single-employee-screen.dart';
import 'package:admin/hospitalemployee/presentation/screen/update-employee-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../global/logic/cubits/hospital/single_hospital_cubit.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';
import '../../../global/services/auth_service.dart';
import '../../logic/block/hospital-employe-block.dart';

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
          if (state.hospital == null) {
            print(RepositoryProvider.of<AuthService>(context).user?.hospitalId);
            BlocProvider.of<SingleHospitalCubit>(context).getHospital(
                RepositoryProvider.of<AuthService>(context).user!.hospitalId!);
          }
          print(state.hospital);
          return state.hospital == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : TableContainer(
                  headerTrailing: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Add hospital employee'),
                    onPressed: () {
                      String name = '';
                      String email = '';
                      String password = '';
                      String phoneNumber = '';

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Add hospital employee'),
                            content: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Name'),
                                    onChanged: (value) => name = value,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Email'),
                                    onChanged: (value) => email = value,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Password'),
                                    onChanged: (value) => password = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Phone Number'),
                                    onChanged: (value) => phoneNumber = value,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ),
                                onPressed: () {
                                  BlocProvider.of<SingleHospitalCubit>(context)
                                      .addHospitalEmployee({
                                    "hospitalId": state.hospital!.id,
                                    "name": name,
                                    "email": email,
                                    "password": password,
                                    "phoneNumber": phoneNumber,
                                  });
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('Add'),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                ),
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

                  //     BlocProvider.of<SingleHospitalCubit>(context).addHospitalEmployee({
                  //       "hospitalId": state.hospital!.id,
                  //       "email": "ts@rt.bg",
                  //       "password": "12345678",
                  //       "phoneNumber": "12345678",
                  //       "name": "test",
                  //     });
                  //    },
                  //   icon: Icon(Icons.add),
                  //   label: Text("Add Employee"),
                  // ),
                  title: 'Hospital Employee',
                  table: DataTable(
                      columnSpacing: defaultPadding,
                      columns: [
                        // DataColumn(
                        //   label: Text('ID'),
                        // ),
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
                          (index) => DataRow(cells: [
                                // DataCell(
                                //     Text(state.hospital!.employees![index].id)),
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
                                    state.hospital!.employees![index]
                                            .phoneNumber ??
                                        "-",
                                  ),
                                ),
                                DataCell(
                                  Text(state
                                      .hospital!.employees![index].hospitalId),
                                ),
                                DataCell(Row(children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('Delete Hospitals'),
                                            content: Text(
                                                'Are you sure you want to delete this Hospitals?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              HospitalEmployeeBloc>(
                                                          context)
                                                      .add(DeleteHospitalEmployee(
                                                          state
                                                              .hospitalemployee[
                                                                  index]
                                                              .id));
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateEmployeeScreen(
                                                    employee: state.hospital!
                                                        .employees![index])),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleEmployeeScreen(
                                                  hospitalemployee: state
                                                      .hospital!
                                                      .employees![index]),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]))
                              ]))));
        })
      ],
    );
  }
}
