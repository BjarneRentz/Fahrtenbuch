import 'package:fahrtenbuch/add_ride.dart';
import 'package:fahrtenbuch/ride_dashboard.dart';
import 'package:fahrtenbuch/ride_overview.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  final List<Widget> widgets = [RideOverview(), RideDashboard()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mein Fahrtenbuch'),
      ),
      body: widgets.elementAt(index),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddRide()))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavigationBar(
        
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          label: 'Fahrten'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Übersicht')
      ],
      currentIndex: index,
      onTap: (index) => setState(() => 
        this.index = index),
      ),
    );
  }
}