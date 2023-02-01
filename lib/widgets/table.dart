import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';

import '../providers/atm_provider.dart';


class CustomTable extends StatelessWidget {
  final ATMProvider ATMInfo;
  CustomTable({required this.ATMInfo});
  @override
  Widget build(BuildContext context) {
    
      List<Map<String, Object>> tableData = [
        {
          'title': 'Kind of ATM',
          'value': ATMInfo.type == Type.Withdraw ? 'Withdraw' : 'Deposit',
        },
        {
          'title': 'Minimum limits',
          'value': '50.000VNĐ',
        },
        {
          'title': 'Cash through bank',
          'value': ATMInfo.cashThroughBank == true ? 'Available' : 'Not availabe',
        },
        {
          'title': 'Number of ATMs',
          'value': '2',
        },
      ];
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
