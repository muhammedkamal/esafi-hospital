// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:your_app/services/auth_service.dart';

// import '../../../global/services/auth_service.dart';

// class UpdatePasswordDialogWidget extends StatefulWidget {
//   @override
//   _UpdatePasswordDialogWidgetState createState() =>
//       _UpdatePasswordDialogWidgetState();
// }

// class _UpdatePasswordDialogWidgetState
//     extends State<UpdatePasswordDialogWidget> {
//   final TextEditingController _oldController = TextEditingController();
//   final TextEditingController _newController = TextEditingController();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final bgColor = Theme.of(context).backgroundColor;
//     final primaryColor = Theme.of(context).primaryColor;

//     return BlocProvider(
//       create: (_) => AuthService(),
//       child: Builder(
//         builder: (context) => AlertDialog(
//           backgroundColor: bgColor,
//           title: Text(
//             'Change Password',
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: _oldController,
//                   decoration: InputDecoration(
//                     focusColor: Colors.grey,
//                     labelText: 'Old Password',
//                     hintText: 'Old Password',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color:Colors.black),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue),
//                     ),
//                   ),
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: _newController,
//                   decoration: InputDecoration(
//                     labelText: 'New Password',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue),
//                     ),
//                   ),
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 16.0),
//               ],
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () async {
//                 print("here");
//                 if (isLoading) {
//                   return;
//                 }
//                 setState(() {
//                   isLoading = true;
//                 });
//                 try {
//                   await RepositoryProvider.of<AuthService>(context)
//                       .ChangePassword(
//                           _oldController.text, _newController.text);
//                   Navigator.of(context).pop();
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(e.toString()),
//                     ),
//                   );
//                 }

//                 setState(() {
//                   isLoading = false;
//                 });
//               },
//               child: isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Text(
//                       'Save',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                       ),
//                     ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 10.0,
//                 ),
//               ),
//             ),
//             if (!isLoading)
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: isLoading
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 16.0,
//                           ),
//                         ),
//                       ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 10.0,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }