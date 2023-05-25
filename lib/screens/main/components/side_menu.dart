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
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Request",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(0);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Admins",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(1);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Drivers", //awaad
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(2);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Ambulances", //awaad
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              BlocProvider.of<ScreenHandlerCubit>(context).changeScreen(3);
            },
          ),
          SizedBox(
            height: defaultPadding,
          ),
          DrawerListTile(
            title: "Change Password",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('ChangePassword'),
                    content: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _oldController,
                            decoration:
                                InputDecoration(labelText: 'old Password'),
                          ),
                          TextFormField(
                            controller: _newController,
                            decoration:
                                InputDecoration(labelText: 'New Password'),
                          ),
                        ],
                      ),
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
                            : Text('Save'),
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
                              : Text('Cancel'),
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
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              BlocProvider.of<AuthBloc>(context).add(SignOut());
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
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
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
