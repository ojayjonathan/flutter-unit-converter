import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './main.dart';

String nbsp = '\u00A0';

const List<String> keyBoardLetters = [
  '7',
  '8',
  '9',
  '4',
  '5',
  '6',
  '1',
  '2',
  '3',
  '0',
  '.'
];

class Conversion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBar conversionNavBar = AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pushNamed(context, '/'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Image.asset(
              'images/$activeMeasurementUnitName.png',
              width: 32,
              height: 32,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 34, 34, 34),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                '$activeMeasurementUnitName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'RussoOne',
                ),
              )),
        ],
      ),
      backgroundColor: Colors.black,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: conversionNavBar,
      body: ConversionSection(),
    );
  }
}

class ConversionSection extends StatefulWidget {
  @override
  _ConversionSectionState createState() => _ConversionSectionState();
}

class _ConversionSectionState extends State<ConversionSection> {
  Widget keyBoard() => GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        crossAxisCount: 3,
        childAspectRatio: 2,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
              decoration:
                  keybordDecoration(bgColor: Color.fromARGB(255, 17, 17, 17)),
              child: TextButton(
                onPressed: negativePositiveToggle,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: Text(
                    '\u00B1',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              )),
          Container(
            decoration:
                keybordDecoration(bgColor: Color.fromARGB(255, 17, 17, 17)),
            child: TextButton(
              onPressed: clear,
              child: Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  'C',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                keybordDecoration(bgColor: Color.fromARGB(255, 17, 17, 17)),
            child: TextButton(
                onPressed: backspace,
                child: Icon(
                  Icons.backspace,
                  color: Colors.white,
                )),
          ),
          ...keyBoardLetters.map((e) => letter(e)),
          Container(
            decoration: keybordDecoration(),
            child: IconButton(
                tooltip: 'copied result to clipboard',
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: '$conversionResult')),
                icon: Icon(
                  Icons.copy,
                  color: Colors.white,
                )),
          ),
        ],
      );

  Container letter(String l) => Container(
        decoration: keybordDecoration(),
        child: TextButton(
          onPressed: () => buttonClick(l),
          child: Text(
            l,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );

  void negativePositiveToggle() {
    setState(() {
      if (inputValue.contains('-')) {
        inputValue = inputValue.substring(1, inputValue.length);
      } else
        inputValue = '-' + inputValue;
      setFinalConversionResult();
    });
  }

  void backspace() {
    setState(() {
      if (inputValue.length > 1 && !inputValue.contains('-')) {
        inputValue = inputValue.substring(0, inputValue.length - 1);
      } else
        inputValue = '0';
      setFinalConversionResult();
    });
  }

  void clear() {
    setState(() {
      inputValue = '0';
      setFinalConversionResult();
    });
  }

  void buttonClick(String v) {
    setState(() {
      if (inputValue == '0' && v != '.') {
        inputValue = v;
      } else if (v == '.' && inputValue.contains('.')){
        
      }
      
      else if (inputValue == '-0' && v != '.')
        inputValue = '-' + v;
      else {
        inputValue = inputValue + v;
      }

      setFinalConversionResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${nbsp * 2}From',
              style: TextStyle(color: Colors.white70),
            ),
            GestureDetector(
              child: Container(
                // alignment: Alignment.center,
                width: 250,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                margin: EdgeInsets.fromLTRB(0, 25, 5, 10),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white70,
                    ),
                    Text(
                      '${selectedFromUNit["name"]} - ${selectedFromUNit["unit"]}${nbsp * 3}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 34, 34, 34),
                  borderRadius: BorderRadius.circular(999.0),
                ),
              ),
              onTap: () =>
                  Navigator.pushNamed(context, '/listview', arguments: 'from'),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            '$inputValue',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${nbsp * 2}To',
              style: TextStyle(color: Colors.white70),
            ),
            GestureDetector(
              child: Container(
                // alignment: Alignment.center,
                width: 250,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white70,
                    ),
                    Text(
                      '${selectedToUnit["name"]} - ${selectedToUnit["unit"]}${nbsp * 2}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 34, 34, 34),
                  borderRadius: BorderRadius.circular(999.0),
                ),
              ),
              onTap: () =>
                  Navigator.pushNamed(context, '/listview', arguments: 'to'),
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              conversionResult,
              style: TextStyle(
                color: Colors.lightBlue[200],
                fontSize: 26,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        keyBoard()
      ],
    );
  }
}

BoxDecoration keybordDecoration({Color bgColor}) => BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 0),
        )
      ],
      color: bgColor ?? Colors.black,
      borderRadius: BorderRadius.circular(2),
    );
