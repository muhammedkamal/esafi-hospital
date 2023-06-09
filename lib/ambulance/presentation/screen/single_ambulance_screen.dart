import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/data/models/hospitals.dart';
import '../../logic/ambulance_bloc/ambulance_bloc.dart';
import '../../logic/ambulance_bloc/ambulance_event.dart';

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
