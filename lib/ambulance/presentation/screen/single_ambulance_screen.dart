import 'package:flutter/material.dart';

import '../../../global/data/models/hospitals.dart';

class SingleAmbulanceScreen extends StatelessWidget {
  final Ambulance ambulance; // add the 'ambulance' named parameter

  const SingleAmbulanceScreen({Key? key, required this.ambulance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // build the widget using the 'ambulance' parameter
    return Scaffold(
      appBar: AppBar(
        title: Text('View Ambulance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Driver ID: ${ambulance.driverId}'),
            Text('Hospital ID: ${ambulance.hospitalId}'),
            Text('ID: ${ambulance.id}'),
            Text('Position: ${ambulance.currentPosition}'),
          ],
        ),
      ),
    );
  }
}
