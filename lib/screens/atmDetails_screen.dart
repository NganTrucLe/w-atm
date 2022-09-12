import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../widgets/generalInfo.dart';

class ATMDetailsScreen extends StatelessWidget {
  static const routeName = '/ATM-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ATM Details'),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.7,
                maxChildSize: 0.7,
                minChildSize: 0.2,
                snapSizes: [0.2, 0.4, 0.7],
                snap: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: SmoothRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(14), bottom: Radius.zero),
                          smoothness: 0.6,
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: GeneralInfo(scrollController)));
                },
              ),
            ),
          ],
        ));
  }
}


/*ListView.builder(
                          itemCount: 5,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 120),
                                child: Column(
                                  children: [
                                    Divider(
                                      thickness: 5,
                                      color: Color.fromARGB(255, 161, 161, 161),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Card(
                                child: ListTile(
                                  title: Text('${index}'),
                                ),
                              );
                            }
                          },
                        ),*/