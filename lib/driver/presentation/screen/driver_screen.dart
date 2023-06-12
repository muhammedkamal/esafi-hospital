import 'package:admin/global/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';
import '../../../responsive.dart';
import '../../logic/bloc/driver_bloc.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({
    Key? key,
  }) : super(key: key);
  // final AmbulanceDriver hospitalId;
  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Drivers',
      widgets: [
        BlocBuilder<DriverBloc, DriverState>(
          builder: (context, state) {
            String name = '';
            String phoneNumber = '';
            String email = '';
            String password = '';
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Add New Driver'),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Name'),
                                  onChanged: (value) => name = value,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Phone Number'),
                                  onChanged: (value) => phoneNumber = value,
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
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // var hospital;
                                BlocProvider.of<DriverBloc>(context)
                                    .createDriver({
                                  "hospitalId":
                                      RepositoryProvider.of<AuthService>(
                                              context)
                                          .user!
                                          .hospitalId!,
                                  "email": email,
                                  "password": password,
                                  "phoneNumber": phoneNumber,
                                  "name": name,
                                });

                                Navigator.pop(context);
                              },
                              child: Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.add,
                  ),
                  label: Text("Add New Driver"),
                ),
              ],
            );
          },
        ),
        SizedBox(
          height: defaultPadding,
        ),
        BlocBuilder<DriverBloc, DriverState>(
          builder: (context, state) {
            if (state is DriverInitial) {
              BlocProvider.of<DriverBloc>(context).add(LoadDriver(
                RepositoryProvider.of<AuthService>(context).user!.hospitalId!,
              ));
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DriverLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (state is DriverLoaded) {
              print(state.driver);
              return TableContainer(
                title: "Drivers",
                table: DataTable(
                  columnSpacing: defaultPadding,
                  //minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Driver ID"),
                    ),
                    DataColumn(
                      label: Text("Hospital ID"),
                    ),
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Phone Number"),
                    ),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: List.generate(
                    state.driver.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(state.driver[index].id)),
                        DataCell(Text(state.driver[index].hospitalId)),
                        DataCell(Text(state.driver[index].name)),
                        DataCell(Text(state.driver[index].phoneNumber)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
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
                                            BlocProvider.of<DriverBloc>(context)
                                                .add(DeleteDriver(
                                                    state.driver[index].id));
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Placeholder();
          },
        )
      ],
    );
  }
}
