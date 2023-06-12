import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/logic/cubits/hospital/single_hospital_cubit.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';
import '../../logic/ambulance_bloc/ambulances_bloc.dart';
import 'single_ambulance_screen.dart';
import 'update_single_ambulance_screen.dart';

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
                : BlocBuilder<AmbulancesBloc, AmbulancesState>(
                    builder: (context, ambulancesstate) {
                      if (ambulancesstate is AmbulancesLoaded) {
                        state.hospital!.ambulances = ambulancesstate.ambulances;
                      }
                      return TableContainer(
                        headerTrailing: ElevatedButton.icon(
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
                                              labelText: 'DriverID'),
                                          onChanged: (value) {
                                            data['DriverID'] = value;
                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'CarNum'),
                                          onChanged: (value) {
                                            data['CarNum'] = value;
                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Position-lat'),
                                          onChanged: (value) {
                                            data['lat'] = value;
                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Position-long'),
                                          onChanged: (value) {
                                            data['long'] = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await BlocProvider.of<
                                                SingleHospitalCubit>(context)
                                            .addAmbulanceToHospital({
                                          "hospitalId": state.hospital!.id,
                                          "driverId": data['DriverID'],
                                          "id": data['CarNum'],
                                          "position": GeoPoint(
                                              double.parse(data['lat']),
                                              double.parse(data['long'])),
                                        });
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
                          icon: Icon(Icons.add),
                          label: Text("Add Ambulance"),
                        ),
                        title: 'Ambulance',
                        table: DataTable(
                          columnSpacing: 10,
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
                                DataCell(Text(state.hospital!.ambulances![index]
                                        .driverId ??
                                    "-")),
                                DataCell(
                                  Text(
                                    state.hospital!.ambulances![index].id,
                                  ),
                                ),
                                DataCell(
                                  Text(state
                                      .hospital!.ambulances![index].hospitalId),
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
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SingleAmbulanceScreen(
                                                      ambulance: state.hospital!
                                                          .ambulances![index]),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateAmbulanceScreen(
                                                      ambulance: state.hospital!
                                                          .ambulances![index]),
                                            ),
                                          );
                                        },
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
                                              title: Text("Delete Ambulance"),
                                              content: Text(
                                                'Are you sure you want to delete this ambulance?',
                                              ),
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
                                                                AmbulancesBloc>(
                                                            context)
                                                        .add(
                                                      DeleteAmbulances(state
                                                          .hospital!
                                                          .ambulances![index]
                                                          .id),
                                                    );
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
                                          color: Colors.black,
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
                    },
                  );
          },
        ),
      ],
    );
  }
}
