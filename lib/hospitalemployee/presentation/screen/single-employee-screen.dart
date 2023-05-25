import 'package:flutter/material.dart';

import '../../../global/data/models/hospitals.dart';

class SingleEmployeeScreen extends StatelessWidget {
  const SingleEmployeeScreen({Key? key, required this.hopitalemployee})
      : super(key: key);
  final HospitalEmployee hopitalemployee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hopitalemployee.id),
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
                  DataCell(Text('ID')),
                  DataCell(Text(hopitalemployee.id)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Name')),
                  DataCell(Text(hopitalemployee.name)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Phone Number')),
                  DataCell(Text(hopitalemployee.phoneNumber ?? "-")),
                ]),
                DataRow(cells: [
                  DataCell(Text('Email')),
                  DataCell(Text(hopitalemployee.email)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Hospital ID')),
                  DataCell(Text(hopitalemployee.hospitalId)),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
