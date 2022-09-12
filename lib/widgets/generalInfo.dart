import 'package:flutter/material.dart';

import './table.dart';

class GeneralInfo extends StatelessWidget {
  final ScrollController scrollController;

  GeneralInfo(this.scrollController);

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItem = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: Column(
          children: [
            Divider(
              thickness: 5,
              color: Color.fromARGB(255, 161, 161, 161),
            ),
          ],
        ),
      ),
      Text('ACB - Da Kao', style: TextStyle(fontSize: 20)),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //textBaseline: TextBaseline.alphabetic,
        children: [
          Icon(Icons.location_on_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Text('232 Pasteur, Ward 10, District 1'),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.call_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Text('+84 28 6265 3500'),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.access_time_filled_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Not too crowded'),
              Text('Estimated time: 6 mins'),
            ],
          ),
        ],
      ),
      CustomTable(),
    ];
    return ListView.builder(
      itemCount: listItem.length,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: listItem[index],
        );
      },
    );
  }
}
