// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../constants.dart';
// import '../../../global/presentation/components/table_container.dart';
// import '../../../global/presentation/templets/main_ui_templete.dart';
// import '../../logic/block/hospital-employe-block.dart';
// import '../../logic/block/hospital-employe-event.dart';
// import '../../logic/block/hospital-employe-state.dart';
// import 'single-employee-screen.dart';


// class HospitalEmployeeScreen extends StatelessWidget {
//   const HospitalEmployeeScreen ({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScreensUITemplete(
//       onSearchChanged: (value) {
//         print(value);
//       },
//       title: "Hospital Employee",
//       widgets: [
//         BlocBuilder<HospitalEmployeeBloc , HospitalEmployeeState>(
//           builder: (context, state) {
//             if (state is HospitalEmployeeInitial) {
//               BlocProvider.of<HospitalEmployeeBloc>(context).add(LoadHospitalEmployee());
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is HospitalEmployeeLoading) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is HospitalEmployeeLoaded) {
//               print(state.hospitalemployee);
//               return TableContainer(
//                 title: "Hospital Employee",
//                 table: DataTable2(
//                     columnSpacing: defaultPadding,
//                     //minWidth: 600,
//                     columns: [
//                       DataColumn(
//                         label: Text(" ID "),
//                       ),
//                       DataColumn(
//                         label: Text(" Name "),
//                       ),
//                       DataColumn(
//                         label: Text(" Phone Number "),
//                       ),
//                       DataColumn(
//                         label: Text("email"),
//                       ),
//                       DataColumn(
//                         label: Text("Hospital ID"),
//                       ),
//                     ],
//                     rows: List.generate(
//                       state.hospitalemployee.length,
//                       (index) => DataRow(
//                         cells: [
//                           DataCell(Text(state.hospitalemployee[index].id)),
//                           DataCell(Text(state.hospitalemployee[index].name)),
//                           DataCell(Text(state.hospitalemployee[index].phoneNumber)),
//                           DataCell(Text(state.hospitalemployee[index].email)),
//                           DataCell(Text(state.hospitalemployee[index].hospitalId)),
//                           DataCell(
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.remove_red_eye,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             SingleEmployeeScreen(
//                                           hopitalemployee: state.hospitalemployee[index],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.delete,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (_) => AlertDialog(
//                                         title: Text('Delete video'),
//                                         content: Text(
//                                             'Are you sure you want to delete this user?'),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text('Cancel'),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               BlocProvider.of<HospitalEmployeeBloc>(
//                                                       context)
//                                                   .add(DeleteHospitalEmployee(state
//                                                       .hospitalemployee[index].id));
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text('Delete'),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//               );
//             }
//             return Placeholder();
//           },
//         )
//       ],
//     );
//   }
// }


