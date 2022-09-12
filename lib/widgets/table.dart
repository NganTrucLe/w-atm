import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  @override
  static const List<Map<String, Object>> tableData = [
    {
      'title': 'Kind of ATM',
      'value': 'Withdraw',
    },
    {
      'title': 'Minimum limits',
      'value': '50.000VNĐ',
    },
  ];
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
          bottom:
              BorderSide(width: 0.5, color: Color.fromRGBO(60, 60, 67, 0.36))),
      children: tableData
          .map((row) => TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      height: 30,
                      child: Text(
                        '${row['title']}',
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      height: 30,
                      child: Text(
                        '${row['value']}',
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}