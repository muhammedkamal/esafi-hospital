import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin/global/data/models/admin.dart';

import '../../../global/data/models/hospitals.dart';
import '../../logic/block/hospital-employe-block.dart';


class UpdateEmployeeScreen extends StatefulWidget {
  final HospitalEmployee employe;

  UpdateEmployeeScreen({required this.employe});

  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState(employe);
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final HospitalEmployee employe;

  _UpdateEmployeeScreenState(this.employe);

  String? _name;
  String? _email;
  String? _id;
  String? _phoneNumber;
  String? _hospitalId;

 

  @override
  void initState() {
    _name = employe.name;
    _email = employe.email;
    _id = employe.id;
    _phoneNumber = employe.phoneNumber;
    _hospitalId = employe.hospitalId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Admin'),
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
                      hintText: 'Enter first name',
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    // initialValue: _lastName,
                    decoration: InputDecoration(
                      hintText: 'Enter last name',
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      //  _lastName = value;
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
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  // TextFormField(
                  //   initialValue: _phoneNumber,
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter phone number',
                  //     labelText: 'Phone Number',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your phone number';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     _phoneNumber = value;
                  //   },
                  // ),
                  // TextFormField(
                  //   initialValue: _idPhotoUrl,
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter ID photo URL',
                  //     labelText: 'ID Photo URL',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your ID photo URL';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     _idPhotoUrl = value;
                  //   },
                  // ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Admin updatehospitalemployee = Admin(
                            id: employe.id,
                            name: _name!,
                            email: _email!,

                          );

                          // BlocProvider.of<HospitalEmployeeBloc>(context)
                          //     .add(updatehospitalemployee(employe.id, updatehospitalemployee));
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
