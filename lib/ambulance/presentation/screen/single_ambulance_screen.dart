import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/data/models/hospitals.dart';
import '../../logic/block/ambulance_block.dart';
import '../../logic/block/ambulance_event.dart';


class SingleAmbulanceScreen extends StatelessWidget {
  final Ambulance ambulance; // add the 'admin' named parameter

  const SingleAmbulanceScreen({Key? key, required this.ambulance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // build the widget using the 'admin' parameter
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Ambulance'),
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
