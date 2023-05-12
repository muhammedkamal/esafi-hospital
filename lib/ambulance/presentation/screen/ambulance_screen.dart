
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';



import '../../../global/presentation/templets/main_ui_templete.dart';



class AmbulanceScreen extends StatefulWidget {
  const AmbulanceScreen({Key? key}) : super(key: key);

  @override
  State<AmbulanceScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<AmbulanceScreen> {
 
  @override
  Widget build(BuildContext context) {
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Ambulance',
      widgets: [
        
      ],
    );
  }
}
