import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:fahrtenbuch/ride_dashboard.dart';
import 'package:fahrtenbuch/ride_overview.dart';
import 'package:fahrtenbuch/views/widgets/edit_ride.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> widgets = [RideOverview(), RideDashboard()];
  final List<String> appTitles = ["Fahrten", "Übersicht"];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitles[index]),
        actions: [
          IconButton(
              onPressed: () => showAboutDialog(
                  context: context,
                  applicationName: 'Fahrtenbuch',
                  applicationLegalese: 'Github.com/BjarneRentz/Fahrtenbuch'),
              icon: Icon(Icons.info))
        ],
      ),
      body: widgets.elementAt(index),
      floatingActionButton: FloatingActionButton(
          child: Icon(Provider.of<RideProvider>(context).hasUnfinishedRides
              ? Icons.done_all
              : Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 16.0,
                          left: 16.0,
                          right: 16.0),
                      child: EditRide(
                        ride: Provider.of<RideProvider>(context, listen: false)
                            .unfinishedRide,
                        rideProvider:
                            Provider.of<RideProvider>(context, listen: false),
                        onSubmittedCallback: () => Navigator.pop(context),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Fahrten'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insights), label: 'Übersicht')
        ],
        currentIndex: index,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
