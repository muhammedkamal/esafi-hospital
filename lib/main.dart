import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/driver/logic/bloc/driver_bloc.dart';
import 'package:admin/global/logic/blocs/auth/auth_bloc.dart';
import 'package:admin/global/logic/cubits/hospital/single_hospital_cubit.dart';
import 'package:admin/global/services/auth_service.dart';
import 'package:admin/requests/logic/requests_handler/requests_handler_cubit.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'global/logic/cubits/screens_handler/screens_handler_cubit.dart';
import 'global/presentation/screens/sign_in_screen.dart';
import 'hospitalemployee/logic/block/hospital-employe-block.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ScreenHandlerCubit(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              RepositoryProvider.of<AuthService>(context),
            )..add(CheckAuth()),
          ),
          BlocProvider(
            create: (context) => SingleHospitalCubit(),
          ),
          BlocProvider(
            create: (context) => RequestsHandlerCubit(),
          ),
          BlocProvider(
            create: (context) => DriverBloc(),
          ),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is Authenticated) {
              BlocProvider.of<SingleHospitalCubit>(context)
                  .getHospital(state.user.hospitalId!);
              BlocProvider.of<RequestsHandlerCubit>(context)
                  .getRequests(state.user.hospitalId!);
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              BlocProvider.of<AuthBloc>(context).add(CheckAuth());
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Esaafi Hospital Panel',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: bgColor,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.white),
                canvasColor: secondaryColor,
              ),
              home: state is Authenticated
                  ? MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuAppController(),
                        ),
                      ],
                      child: MainScreen(),
                    )
                  : SignInScreen(),
              routes: {
                '/main': (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuAppController(),
                        ),
                      ],
                      child: MainScreen(),
                    )
              },
            );
          },
        ),
      ),
    );
  }
}
