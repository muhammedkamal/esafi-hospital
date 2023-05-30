import 'package:flutter/material.dart';
import '../../../global/data/models/hospitals.dart';

class SingleEmployeeScreen extends StatelessWidget {
  const SingleEmployeeScreen({Key? key, required this.hospitalemployee})
      : super(key: key);
  final HospitalEmployee hospitalemployee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalemployee.id),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: DataTable(columns: [
                DataColumn(label: Text('Feild')),
                DataColumn(label: Text('Data')),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text('Name')),
                  DataCell(Text(hospitalemployee.name)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Email')),
                  DataCell(Text(hospitalemployee.email)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Phone Number')),
                  DataCell(Text(hospitalemployee.phoneNumber!)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Hospital ID')),
                  DataCell(Text(hospitalemployee.hospitalId)),
                ]),
              ]),
            ),
          )
        ]
      ),
          );
  }
}