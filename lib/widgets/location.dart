import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watm/theme/colors.dart';
import '../providers/origins_provider.dart';

class userLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final origins = Provider.of<OriginsProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white.withOpacity(0.8),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'Your location',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors().neutral500,
              ),
            ),
            subtitle: Text(
              "${origins.currentAddress} ${origins.currentLocation.latitude} ${origins.currentLocation.longitude}",
              style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
