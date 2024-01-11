import 'package:currency_conversion/ui/exchange.dart';
import 'package:currency_conversion/ui/home.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;

  Widget getPage() {
    if (_selectedIndex == 0) {
      return Home();
    } else {
      return Exchange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF900C3F),
        appBar: AppBar(
          title: Text(
            "Currency Conversion App",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFF581845),
          centerTitle: true,
        ),
        body: getPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Color(0xFF884EA0),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14.0,
          unselectedFontSize: 12.0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: "Exchange",
            ),
          ],
        ),
      ),
    );
  }
}
