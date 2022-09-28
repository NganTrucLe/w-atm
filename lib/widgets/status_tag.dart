import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';

enum Status {
  working('Working', const Color(0xFFD1EBBE), const Color(0xFF64BC26)),
  crowded('Crowded', const Color(0xFFFEE0B3), const Color(0xFFFD9900)),
  maintenance('Maintenance', Color.fromARGB(255, 174, 174, 174), Color.fromARGB(255, 92, 92, 92));


  const Status(this.status, this.backgroundColor, this.textColor);
  final String status;
  final Color backgroundColor;
  final Color textColor;
}

class StatusTag extends StatelessWidget {
  @override
  final Status status;
  StatusTag(this.status);
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: ShapeDecoration(
          color: status.backgroundColor,
          shape: SmoothRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            smoothness: 0.6,
          ),
        ),
        child: FittedBox(
          child: Row(
            children: [
              Text(status.status, style: TextStyle(color: status.textColor)),
              SizedBox(width: 4),
              new SvgPicture.asset('assets/images/iconStatus.svg',
                  height: 24,
                  color: status.textColor),
            ],
          ),
        ));
  }
}
