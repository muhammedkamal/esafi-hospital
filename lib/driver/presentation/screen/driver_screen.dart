import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';
import '../../logic/bloc/driver_bloc.dart';

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
        BlocBuilder<DriverBloc, DriverState>(
          builder: (context, state) {
            if (state is DriverInitial) {
              BlocProvider.of<DriverBloc>(context).add(LoadDriver());
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
                        DataCell(Text(state.driver[index].ambulanceId)),
                        DataCell(Text(state.driver[index].hospitalId)),
                        DataCell(Text(state.driver[index].name)),
                        DataCell(
                            Text(describeEnum(state.driver[index].phoneNumber))),
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
                                onPressed: () {},
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
            }
            return Placeholder();
          },
        )
      ],
    );
  }
}
