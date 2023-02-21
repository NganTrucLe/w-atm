import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'atm_item_card.dart';
import '../providers/atms_provider.dart';

class ATMlist extends StatefulWidget {
  @override
  State<ATMlist> createState() => _ATMlistState();
}

class _ATMlistState extends State<ATMlist> {
  var _isInit = true;
  var _isLoading = false;

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
      Provider.of<ATMs>(context).readJson().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ATMsData = Provider.of<ATMs>(context).listATMs;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _isLoading
            ? CircularProgressIndicator()
            : Container(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                height: 200,
                child: ListView.builder(
                  itemCount: ATMsData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (cxt, i) => ChangeNotifierProvider.value(
                    value: ATMsData[i],
                    child: ATM_item_card(),
                  ),
                ),
              )
      ],
    );
  }
}
