import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:fahrtenbuch/views/widgets/edit_ride.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/ride.dart';

class AddRide extends StatefulWidget {
  const AddRide({Key? key}) : super(key: key);

  @override
  _AddRideState createState() => _AddRideState();
}

class _AddRideState extends State<AddRide> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fahrt hinzufügen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: EditRide(submitRide: submitRide,),
      ),
    );
  }

  void submitRide(Ride ride) {
    var rideProvider = Provider.of<RideProvider>(context, listen: false);
    rideProvider.add(ride);

    Navigator.pop(context);
  }
}
