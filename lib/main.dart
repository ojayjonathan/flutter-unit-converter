import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './conversion.dart';
import './conversionRates.dart';
import './listview.dart';

List<String> allMeasuremetUnits = [
  'Length',
  'Weight',
  'Time',
  'Temp',
  'Currency',
  'Speed',
  'Density',
  'Volume',
  'Area',
  'Force',
  'Pressure',
  'Data',
  'Energy',
  'Power',
  'Current',
  'Frequency',
  'Resistance'
];
List<Map> activeMeasurementUnitItems;
String activeMeasurementUnitName;
String inputValue = '0';
String conversionResult = '0';
Map selectedFromUNit = activeMeasurementUnitItems[0];
Map selectedToUnit = activeMeasurementUnitItems[1];

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit convertor',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.black),
      routes: {
        '/': (context) => MyHomePage(),
        '/conversion': (context) => Conversion(),
        '/listview': (context) => UnitsListView(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    homeContext = context;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: navBar,
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            //decoration: BoxDecoration(color: Color.fromARGB(200, 34, 34, 34)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: Text(
                        '16',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'RussoOne',
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 0, 180, 216))),
                Text(
                  'Metric Units'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          unitsGrid
        ],
      ),
    );
  }
}

AppBar navBar = AppBar(
  automaticallyImplyLeading: false,

  title: Container(
    margin: EdgeInsets.fromLTRB(5, 15, 0, 15),
    child: Text(
      'Unit Convertor',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'RussoOne',
          fontSize: 28,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Color.fromARGB(100, 255, 255, 255),
            ),
            // Shadow(
            //   offset: Offset(10.0, 10.0),
            //   blurRadius: 8.0,
            //   color: Color.fromARGB(125, 0, 0, 255),
            // ),
          ],
          color: Color.fromARGB(255, 150, 150, 150)),
    ),
  ),
  //),
  backgroundColor: Color.fromARGB(255, 0, 0, 0),
  actions: [
    IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white70,
        ),
        onPressed: null)
  ],
);

GridView unitsGrid = GridView.count(
  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
  crossAxisCount: 3,
  mainAxisSpacing: 10,
  crossAxisSpacing: 10,
  childAspectRatio: 1.25,
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  children: [
    ...allMeasuremetUnits.map((item) => measurementUnitContainer(
          'images/$item.png',
          '$item',
        )),
  ],
);

InkWell measurementUnitContainer(var icon, String label) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 32,
            width: 32,
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 34, 34, 34),
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    onTap: () => setActiveMeasurementUnit(label),
  );
}

void setActiveMeasurementUnit(String unitName) {
  activeMeasurementUnitName = unitName;
  activeMeasurementUnitItems = conversionRates[activeMeasurementUnitName];
  selectedFromUNit = activeMeasurementUnitItems[0];
  selectedToUnit = activeMeasurementUnitItems[1];
  inputValue = '0';
  conversionResult = '0';
  Navigator.pushNamed(MyHomePage.homeContext, '/conversion');
}

void setFinalConversionResult() {
  double _result;
  if (activeMeasurementUnitName == "Temp") {
    if (selectedToUnit['name'] == 'Celsius' &&
        selectedFromUNit['name'] == 'Kelvin')
      _result = double.parse(inputValue) - 273;
    else if (selectedToUnit['name'] == 'Kelvin' &&
        selectedFromUNit['name'] == 'Celsius')
      _result = double.parse(inputValue) + 273;
    else
      _result = double.parse(inputValue);
  } else
    _result = double.parse(inputValue) *
        double.parse(selectedFromUNit['weight']) /
        double.parse(selectedToUnit['weight']);
  if (_result<0.0001 || _result>1000000000)
       conversionResult= _result.toStringAsPrecision(5);
    else
      conversionResult = _result.toStringAsFixed(4);      
}
