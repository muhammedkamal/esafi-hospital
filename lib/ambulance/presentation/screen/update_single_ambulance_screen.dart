import 'package:admin/global/data/models/hospitals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/block/ambulance_block.dart';
import '../../logic/block/ambulance_event.dart';




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
          title: Text('UpdateAmbulanc'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 1200,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // initialValue: _Ambulance id,
                    TextFormField(
                      initialValue: _id,
                      decoration: InputDecoration(
                        hintText: 'Enter ambulance id',
                        labelText: 'Ambulance Id',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ambulance id is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _id = value;
                      },
                    ),
                    // initialValue: _Ambulance currentPosition,
                    TextFormField(
                      //GeoPoint? _currentPosition,
                      decoration: InputDecoration(
                        hintText: 'Enter ambulance current position',
                        labelText: 'Current Position',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Current Position is required';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    // initialValue: _hospital id,
                    TextFormField(
                      initialValue: _hospitalId,
                      decoration: InputDecoration(
                        hintText: 'Enter hospital id',
                        labelText: 'Hospital Id',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hospital id is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _hospitalId = value;
                      },
                    ),
                    // initialValue: _driver id,
                    TextFormField(
                      initialValue: _driverId,
                      decoration: InputDecoration(
                        hintText: 'Enter driver id',
                        labelText: 'Driver Id',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Driver id is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _driverId = value;
                        
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
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

                              BlocProvider.of<AmbulancesBloc>(context).add(
                                  UpdateAmbulance(ambulance.id,
                                      updateAmbulance as Hospital));
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Save Changes')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }


}
