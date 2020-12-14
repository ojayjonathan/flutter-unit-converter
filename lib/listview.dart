import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './main.dart';

class UnitsListView extends StatefulWidget {
  @override
  _UnitsListViewState createState() => _UnitsListViewState();
}

class _UnitsListViewState extends State<UnitsListView> {
  List<Map> listItems = activeMeasurementUnitItems;
  TextEditingController searchInputControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.clear,
            color: Colors.white70,
          ),
        ),
        title: Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            style: TextStyle(color: Colors.white70, fontSize: 20),
            decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 34, 34, 34),
                focusColor: Color.fromARGB(200, 34, 34, 34),
                border: InputBorder.none,
                hintText: 'search',
                hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                icon: Icon(
                  Icons.search,
                  color: Colors.white70,
                )),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 20),
        shrinkWrap: true,
        children: [
          ...listItems.map((e) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/conversion');
                  if (arg == 'from')
                    selectedFromUNit = e;
                  else
                    selectedToUnit = e;
                  setFinalConversionResult();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              child: activeMeasurementUnitName == 'Currency'
                                  ? currencyImage(e['unit'])
                                  : SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Text(
                                        e['name'][0].toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 24),
                                      ),
                                    ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: activeMeasurementUnitName == 'Currency'
                                      ? Colors.black
                                      : Color.fromARGB(255, 251, 133, 0))),
                          Text(
                            '${e["name"]}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          )
                        ],
                      ),
                      Text(
                        '\u005B${e["unit"]}\u005D',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

Image currencyImage(String currencyCode) {
  return Image.asset(
    'images/$currencyCode.png',
    width: 48,
    height: 40,
  );
}
