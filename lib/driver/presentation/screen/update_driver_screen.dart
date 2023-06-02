import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/driver.dart';
import '../../logic/bloc/driver_bloc.dart';

class UpdateDriverScreen extends StatefulWidget {
  final AmbulanceDriver driver;

  UpdateDriverScreen({required this.driver});

  @override
  _UpdateDriverScreenState createState() => _UpdateDriverScreenState(driver);
}

class _UpdateDriverScreenState extends State<UpdateDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  final AmbulanceDriver driver;

  _UpdateDriverScreenState(this.driver);

  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _hospitalId;
  String? _id;

  @override
  void initState() {
    _name = driver.name;
    _email = driver.email;
    _phoneNumber = driver.phoneNumber;
    _hospitalId = driver.hospitalId;
    _id = driver.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Driver'),
      ),
      body: Padding(
        padding: EdgeInsets.all(160),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _phoneNumber,
                    decoration: InputDecoration(
                      hintText: 'Enter phone Number',
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phoneNumber = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _hospitalId,
                    decoration: InputDecoration(
                      hintText: 'Enter Hospital ID',
                      labelText: 'Hospital ID',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Hospital ID';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _hospitalId = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _id,
                    decoration: InputDecoration(
                      hintText: 'Enter ID',
                      labelText: 'ID',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ID';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _id = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          AmbulanceDriver updatedDriver = AmbulanceDriver(
                            name: _name!,
                            email: _email!,
                            phoneNumber: _phoneNumber!,
                            hospitalId: _hospitalId!,
                            id: _id!,
                          );

                          BlocProvider.of<DriverBloc>(context)
                              .add(UpdateDriver(driver.id, updatedDriver));
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
