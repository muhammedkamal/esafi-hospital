import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/logic/cubits/hospital/single_hospital_cubit.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Drivers',
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
                            .addDriverToHospital({
                          "hospitalId": state.hospital!.id,
                          "email": "ts@rt.bg",
                          "password": "12345678",
                          "phoneNumber": "12345678",
                          "name": "test",
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Driver"),
                    ),
                    title: 'Drivers',
                    table: DataTable(
                      columns: [
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Phone'),
                        ),
                        DataColumn(
                          label: Text('Email'),
                        ),
                        DataColumn(
                          label: Text('Ambulance Id'), //edit
                        ),
                        DataColumn(
                          label: Text('Action'),
                        ),
                      ],
                      rows: List.generate(
                        state.hospital!.drivers!.length,
                        (index) => DataRow(cells: [
                          DataCell(Text(state.hospital!.drivers![index].name)),
                          DataCell(
                            Text(
                              state.hospital!.drivers![index].phoneNumber,
                            ),
                          ),
                          DataCell(
                            Text(
                              state.hospital!.drivers![index].email ?? "-",
                            ),
                          ),
                          DataCell(Text(
                              state.hospital!.drivers![index].ambulanceId ??
                                  "-")),
                          DataCell(Text(state.hospital!.drivers![index].id)),
                        ]),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
