import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/logic/blocs/auth/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen();
  static const String routeName = 'SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _passwordVisible = false;
  Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Form(
              key: formKey,
              autovalidateMode: _validate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/reg_logo.png',
                    width: 112.64,
                    height: 56.32,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Welcome in Hospital Dashboard',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Please login to safely continue your experience',
                    style: TextStyle(
                      color: Colors.black, // Set the text color to black
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OutLinedTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid email Address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      userData['email'] = value;
                    },
                    hintText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutLinedTextFormField(
                    onChanged: (value) {
                      userData['password'] = value;
                    },
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    obscureText: _passwordVisible ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          } else if (state is Authenticated) {
                            Navigator.of(context).pushReplacementNamed('/main');
                          } else if (state is Unauthenticated) {}
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _validate = true;
                              });
                              if (formKey.currentState!.validate()) {
                                if (state is AuthLoading) return;
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthBloc>(context).add(SignIn(
                                      email: userData['email'],
                                      password: userData['password']));
                                } else {
                                  setState(() {
                                    _validate = true;
                                  });
                                }
                              }
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      color: Colors.red, width: 2),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.infinity, 60)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            child: state is AuthLoading
                                ? const CircularProgressIndicator(
                                    color: primaryColor,
                                  )
                                : const Text('Continue'),
                          );
                        },
                      ),
                      // child: ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(
                      //         context, SignInScreen.routeName);
                      //   },
                      //   child: const Text(
                      //     'Continue',
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.red,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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

class OutLinedTextFormField extends StatelessWidget {
  const OutLinedTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    required this.onChanged,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.width,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final Function onChanged;
  final Function? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
        },
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.black),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
