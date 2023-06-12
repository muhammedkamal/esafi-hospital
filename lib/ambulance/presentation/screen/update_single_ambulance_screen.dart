import 'package:admin/global/data/models/hospitals.dart';
import 'package:admin/global/logic/cubits/hospital/single_hospital_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/ambulance_bloc/ambulances_bloc.dart';

class UpdateAmbulanceScreen extends StatefulWidget {
  final Ambulance ambulance;

  UpdateAmbulanceScreen({required this.ambulance});

  @override
  _UpdateAmbulanceScreenState createState() =>
      _UpdateAmbulanceScreenState(ambulance);
}

class _UpdateAmbulanceScreenState extends State<UpdateAmbulanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final Ambulance ambulance;

  _UpdateAmbulanceScreenState(this.ambulance);

  String? _id;
  GeoPoint? _currentPosition;
  String? _hospitalId;
  String? _driverId;

  @override
  void initState() {
    _id = ambulance.id;
    _currentPosition = ambulance.currentPosition;
    _hospitalId = ambulance.hospitalId;
    _driverId = ambulance.driverId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Update Ambulance'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Ambulance ID:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(
                  hintText: 'Enter Ambulance ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an Ambulance ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _id = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Text(
                'Hospital ID:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: _hospitalId,
                decoration: InputDecoration(
                  hintText: 'Enter Hospital ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Hospital ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hospitalId = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Text(
                'Driver ID:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: _driverId,
                decoration: InputDecoration(
                  hintText: 'Enter Driver ID (optional)',
                ),
                onSaved: (value) {
                  _driverId = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Ambulance updateAmbulance = Ambulance(
                        id: ambulance.id,
                        currentPosition: _currentPosition,
                        hospitalId: _hospitalId!,
                        driverId: _driverId!,
                      );

                      BlocProvider.of<AmbulancesBloc>(context)
                          .add(UpdateAmbulance(ambulance.id, updateAmbulance));
                      Navigator.pop(context);
                      BlocProvider.of<SingleHospitalCubit>(context)
                          .getHospital(ambulance.hospitalId);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
