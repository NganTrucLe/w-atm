import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../providers/atm_provider.dart';
import '../widgets/atm_list.dart';
import './atm_list_screen.dart';
import '../widgets/map.dart';
import '../widgets/location.dart';
import '../models/filterModel.dart';
import '../providers/origins_provider.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
  List<ATMProvider> ATMItem = [];
  List<ATMProvider> RenderedATMItem = [];
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final origins = Provider.of<OriginsProvider>(context);
      origins.updateLocation().then((_) async {
        // }).then((_) {
        // final renderedData = Provider.of<ATMs>(context);
        // renderedData.readJson().then((_) {
        setState(() {
          // ATMItem = renderedData.items;
          // RenderedATMItem = ATMItem;
          _isLoading = false;
        });
        // });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<dynamic> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    return await json.decode(response);
  }

  void _fullList(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListScreen(),
      ),
    );
  }

  // void _applyFilter() {
  //   var filter = context.read<FilterModel>();
  //   FilterATM filterATM = filter.getFilterATM();
  //   setState(() {
  //     RenderedATMItem = [];
  //     ATMItem.map((item) => {
  //           if (filterATM.bank == "" || item.bank == filterATM.bank)
  //             {RenderedATMItem.add(item)}
  //         }).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //_applyFilter();
    final origins = Provider.of<OriginsProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            origins.currentLocation != LatLng(0, 0)
                ? Map(origins.currentLocation)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            userLocation(),
            origins.currentLocation != LatLng(0, 0)
                ? ATMlist()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.small(
                    child: Icon(
                      Icons.zoom_out_map_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () => _fullList(context),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
    // final dummyATMs = Provider.of<ATMs>(context);
    // print(dummyATMs.items);