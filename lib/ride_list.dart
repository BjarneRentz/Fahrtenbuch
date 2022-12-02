import 'package:fahrtenbuch/models/ride.dart';
import 'package:fahrtenbuch/views/widgets/edit_ride.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'provider/ride_provider.dart';

class RideList extends StatelessWidget {
  const RideList(this.provider, {Key? key}) : super(key: key);

  final RideProvider provider;

  @override
  Widget build(BuildContext context) {
    var finishedRides = provider.rides.where((ride) => ride.finished);
    var openRides = provider.rides.where((ride) => !ride.finished);

    return Column(
      children: [
        for (var ride in openRides)
          Card(
            child: ListTile(
              onTap: () => editRide(context, ride),
              title: Text(
                  "Offene Fahrt am ${DateFormat.yMMMd().format(ride.date)}"),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child:
                          Text('Fahrtbeginn: ${ride.mileageStart / 1000} Km')),
                  TextButton(
                      onPressed: () => removeRide(context, provider, ride),
                      child: Text(
                        'Löschen',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            ),
          ),
        openRides.length > 0 ? Divider() : Container(),
        Expanded(
          child: ListView.builder(
            itemCount: finishedRides.length,
            itemBuilder: (context, index) {
              Ride currentRide = finishedRides.elementAt(index);
              return Card(
                  child: ListTile(
                onTap: () => editRide(context, currentRide),
                title: Text(
                    'Fahrt über ${currentRide.distance / 1000} Km am ${DateFormat.yMMMd().format(currentRide.date)}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(currentRide.description)),
                    TextButton(
                        onPressed: () =>
                            removeRide(context, provider, currentRide),
                        child: Text(
                          'Löschen',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              ));
            },
          ),
        ),
      ],
    );
  }

  void removeRide(BuildContext context, RideProvider provider, Ride ride) {
    provider.remove(ride);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text('Fahrt am ${DateFormat.yMMMd().format(ride.date)} gelöscht'),
      action: SnackBarAction(
        label: 'Rückgängig machen',
        onPressed: () => provider.add(ride),
      ),
    ));
  }

  editRide(BuildContext context, Ride ride) {
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
                ride: ride,
                rideProvider: Provider.of<RideProvider>(context, listen: false),
                onSubmittedCallback: () => Navigator.pop(context),
              ),
            ),
          );
        });
  }
}
