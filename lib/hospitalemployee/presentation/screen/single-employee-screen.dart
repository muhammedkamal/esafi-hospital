import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../global/data/models/hospitals.dart';

class SingleEmployeeScreen extends StatelessWidget {
  const SingleEmployeeScreen({Key? key, required this.hospitalemployee})
      : super(key: key);

  final HospitalEmployee hospitalemployee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(hospitalemployee.id),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Name:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              hospitalemployee.name,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Email:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              hospitalemployee.email,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Phone Number:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              hospitalemployee.phoneNumber ?? "-",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Hospital ID:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              hospitalemployee.hospitalId,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
