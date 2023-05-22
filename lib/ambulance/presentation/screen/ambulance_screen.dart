import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/logic/cubits/hospital/single_hospital_cubit.dart';
import '../../../global/logic/providers/hospital_provider.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';

class AmbulanceScreen extends StatefulWidget {
  const AmbulanceScreen({Key? key}) : super(key: key);
  @override
  State<AmbulanceScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<AmbulanceScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Ambulance',
      widgets: [
        BlocBuilder<SingleHospitalCubit, SingleHospitalState>(
          builder: (context, state) {
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
                            .addAmbulanceToHospital({
                          "hospitalId": state.hospital!.id,
                          "email": "ts@rt.bg",
                          "password": "12345678",
                          "phoneNumber": "12345678",
                          "name": "test",
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Ambulance"),
                    ),
                    title: 'Ambulance',
                    table: DataTable2(
                      columns: [
                        DataColumn(
                          label: Text('Driver Id'),
                        ),
                        DataColumn(
                          label: Text('Car Num.'),
                        ),
                        DataColumn(
                          label: Text('Hospital'),
                        ),
                        DataColumn(
                          label: Text('Position'),
                        ),
                        DataColumn(
                          label: Text('Action'),
                        ),
                      ],
                      rows: List.generate(
                        state.hospital!.ambulances!.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                                Text(state.hospital!.ambulances![index].id)),
                            DataCell(
                              Text(
                                state.hospital!.ambulances![index].hospitalId,
                              ),
                            ),
                            DataCell(
                              Text(
                                state.hospital!.ambulances![index]
                                        .currentPosition
                                        .toString() +
                                    "-",
                              ),
                            ),
                            DataCell(
                              Text(state.hospital!.ambulances![index].driverId),
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
                                          title: Text('Add New Ambulance'),
                                          content: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Driver Id'),
                                                  onChanged: (value) {
                                                    data['Driver Id'] = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Car Num.'),
                                                  onChanged: (value) {
                                                    data['Car Num.'] = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Hospital'),
                                                  onChanged: (value) {
                                                    data['Hospital'] = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      labelText: 'Position'),
                                                  onChanged: (value) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                RepositoryProvider.of<
                                                            HospitalsProvider>(
                                                        context)
                                                    .add((data));
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
