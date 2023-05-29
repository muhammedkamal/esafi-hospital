import 'package:admin/constants.dart';
import 'package:admin/global/logic/blocs/auth/auth_bloc.dart';
import 'package:admin/global/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../global/logic/cubits/screens_handler/screens_handler_cubit.dart';
import '../../../global/services/auth_service.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isLoading = false;
  TextEditingController _oldController = TextEditingController();
  TextEditingController _newController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/reg_logo.png"),
          ),
          DrawerListTile(
<<<<<<< HEAD
            title: "Requests",
            svgSrc: "assets/icons/requests.svg",
=======
            title: "Request",
            svgSrc: "assets/icons/menu_dashbord.svg",
>>>>>>> bf60b4e18b5de867376d3c3d5677111f43c8437e
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(0);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Hospital Empolyees",
            svgSrc: "assets/icons/admins.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(1);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Drivers", //awaad
            svgSrc: "assets/icons/admins.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(2);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Ambulances", //awaad
            svgSrc: "assets/icons/admins.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(3);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),

          //ERROR: change design or try with package
          DrawerListTile(
            title: "Change Password",
            svgSrc: "assets/icons/password.svg",
            press: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 56, 49, 49),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _oldController,
                            decoration: InputDecoration(
                              focusColor: Colors.grey,
                              labelText: 'Old Password',
                              hintText: 'Old Password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _newController,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          print("here");
                          if (isLoading) {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await RepositoryProvider.of<AuthService>(context)
                                .ChangePassword(
                                    _oldController.text, _newController.text);
                            Navigator.of(context).pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                        ),
                      ),
                      if (!isLoading)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10.0,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Logout",
<<<<<<< HEAD
            svgSrc: "assets/icons/logout.svg",
            press: () {},
=======
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              BlocProvider.of<AuthBloc>(context).add(SignOut());
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
>>>>>>> bf60b4e18b5de867376d3c3d5677111f43c8437e
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
