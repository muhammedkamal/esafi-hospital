import 'package:admin/hospitalemployee/logic/block/hospital-employe-event.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin/global/data/models/admin.dart';

import '../../../global/data/models/hospitals.dart';
import '../../logic/block/hospital-employe-block.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final HospitalEmployee employee;

  UpdateEmployeeScreen({required this.employee});

  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _email;
  late String _phoneNumber;

  @override
  void initState() {
    _name = widget.employee.name;
    _email = widget.employee.email;
    _phoneNumber = widget.employee.phoneNumber ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Update Employee'),
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
                'Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Text(
                'Email:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Text(
                'Phone Number:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty && !isNumeric(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      HospitalEmployee updatedEmployee = HospitalEmployee(
                        id: widget.employee.id,
                        name: _name,
                        email: _email,
                        phoneNumber:
                            _phoneNumber.isNotEmpty ? _phoneNumber : null,
                        hospitalId: widget.employee.hospitalId,
                      );
                      BlocProvider.of<HospitalEmployeeBloc>(context).add(
                          UpdateHospitalEmployee(
                              widget.employee.id, updatedEmployee));
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
    );
  }
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
