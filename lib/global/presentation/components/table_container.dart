import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TableContainer extends StatelessWidget {
  const TableContainer({
    Key? key,
    required this.title,
    required this.table,
    this.headerTrailing,
  }) : super(key: key);
  final String title;
  final DataTable2 table;
  final Widget? headerTrailing;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (this.headerTrailing != null) this.headerTrailing!,
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: table,
          ),
        ],
      ),
    );
  }
}
