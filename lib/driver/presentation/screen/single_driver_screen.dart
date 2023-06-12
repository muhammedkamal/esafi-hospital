import 'package:admin/driver/data/model/driver.dart';
import 'package:flutter/material.dart';

class SingleDriverScreen extends StatelessWidget {
  final AmbulanceDriver driver; // add the 'Driver' named parameter

  const SingleDriverScreen({Key? key, required this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // build the widget using the 'Driver' parameter
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Driver'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('driver Name: ${driver.name}'),
            Text('Email: ${driver.email}'),
            Text('Phone Number: ${driver.phoneNumber}'),
            Text('Phone Number: ${driver.hospitalId}'),
            Text('Phone Number: ${driver.id}'),
          ],
        ),
      ),
    );
  }
}
