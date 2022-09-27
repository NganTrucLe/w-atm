import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';

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
    {
      'title': 'Cash through bank',
      'value': 'Available',
    },
    {
      'title': 'Number of ATMs',
      'value': '2',
    },
  ];
  Widget build(BuildContext context) {
    return Table(
      children: tableData
          .map((row) => TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: AppTheme.colors.neutral800,
                    ),
                  ),
                ),
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${row['title']}',
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerRight,
                      child: Text('${row['value']}',
                          style: TextStyle(color: AppTheme.colors.neutral600)),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
