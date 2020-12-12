import 'package:flutter/material.dart';
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
];
List<Map> activeMeasurementUnitItems;
String activeMeasurementUnitName;
String inputValue = '0';
double conversionResult = 0;
Map selectedFromUNit = activeMeasurementUnitItems[0];
Map selectedToUnit = activeMeasurementUnitItems[1];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit convertor',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
            decoration: BoxDecoration(color:Color.fromARGB(255, 34, 34, 34) ),
            child: Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.fromLTRB(15, 5, 20, 5),
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      
                      child: Text(
                        '16',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'KeeponTruckin',
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 0, 180, 216))),
                Text(
                  'Metric Units',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
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
    margin: EdgeInsets.fromLTRB(10, 15, 0, 15),
    child: Text(
      'Unit Convertor',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'KeeponTruckin',
        fontSize: 24,
      ),
    ),
  ),
  //),
  backgroundColor: Color.fromARGB(255, 0, 0, 0),
);

GridView unitsGrid = GridView.count(
  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
  crossAxisCount: 3,
  mainAxisSpacing: 10,
  crossAxisSpacing: 10,
  childAspectRatio: 1.25,
  shrinkWrap: true,
  children: [
    ...allMeasuremetUnits.map((item) => measurementUnitContainer(
          'images/$item.png',
          '$item',
        )),
  ],
);

GestureDetector measurementUnitContainer(var icon, String label) {
  return GestureDetector(
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
  conversionResult = 0;
  Navigator.pushNamed(MyHomePage.homeContext, '/conversion');
}

void setFinalConversionResult() {
  if (activeMeasurementUnitName == "Temp") {
    if (selectedToUnit['name'] == 'Celsius' &&
        selectedFromUNit['name'] == 'kelvin')
      conversionResult = double.parse(inputValue) - 273;
    if (selectedToUnit['name'] == 'kelvin' &&
        selectedFromUNit['name'] == 'Celsius')
      conversionResult = double.parse(inputValue) + 273;
    else
      conversionResult = double.parse(inputValue);
  } else
    conversionResult = double.parse(inputValue) *
        double.parse(selectedFromUNit['weight']) /
        double.parse(selectedToUnit['weight']);
}
