import 'package:admin/global/services/auth_service.dart';
import 'package:admin/requests/data/models/ambulance_request.dart';
import 'package:admin/requests/logic/requests_handler/requests_handler_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../global/presentation/components/table_container.dart';
import '../../../global/presentation/templets/main_ui_templete.dart';

class RequestsScreen extends StatelessWidget {
  RequestsScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<RequestsHandlerCubit>(context).getRequests(
    //     RepositoryProvider.of<AuthService>(context).user!.hospitalId!);
    return ScreensUITemplete(
      onSearchChanged: (value) {
        print(value);
      },
      title: 'Requests',
      widgets: [
        BlocBuilder<RequestsHandlerCubit, RequestsHandlerState>(
          builder: (context, state) {
            return state.requests == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : TableContainer(
                    title: 'Requests',
                    table: DataTable(
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text('ID'),
                        ),
                        DataColumn(
                          label: Text('Type'),
                        ),
                        DataColumn(
                          label: Text('Status'),
                        ),
                        DataColumn(
                          label: Text('Actions'),
                        ),
                      ],
                      rows: List.generate(
                        state.requests!.length,
                        (index) => DataRow(
                          color: state.requests![index].status ==
                                  AmbulanceRequestStatus.pending
                              ? MaterialStateProperty.all(Colors.red[500])
                              : null,
                          cells: [
                            DataCell(
                              Text(state.requests![index].id.toString()),
                            ),
                            DataCell(
                              Text(describeEnum(state.requests![index].type)),
                            ),
                            DataCell(
                              Text(describeEnum(state.requests![index].status)),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  if (state.requests![index].status ==
                                      AmbulanceRequestStatus.pending)
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text("Normal Request"),
                                                  content: Column(
                                                    children: [
                                                      TextFormField(
                                                        controller: controller,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'AmbulanceId',
                                                        ),
                                                      ),
                                                    ],
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    RequestsHandlerCubit>(
                                                                context)
                                                            .acceptRequest(
                                                          state.requests![index]
                                                              .id!,
                                                          controller.text,
                                                          RepositoryProvider.of<
                                                                      AuthService>(
                                                                  context)
                                                              .user!
                                                              .hospitalId!,
                                                          emergency: false,
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors.red),
                                                      ),
                                                      child: Text(
                                                        'Accept Request',
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
