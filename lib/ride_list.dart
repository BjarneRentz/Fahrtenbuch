import 'package:fahrtenbuch/models/ride.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'provider/ride_provider.dart';

class RideList extends StatelessWidget {
  const RideList(this.provider, {Key? key}) : super(key: key);

  final RideProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provider.rides.length,
      itemBuilder: (context, index) {
        Ride currentRide = provider.rides.elementAt(index);
        return Card(
            child: ListTile(
          title: Text(
              'Fahrt über ${currentRide.distance / 1000} Km am ${DateFormat.yMMMd().format(currentRide.date)}'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currentRide.description),
              TextButton(
                  onPressed: () => removeRide(context, provider, currentRide),
                  child: Text(
                    'Löschen',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ));
      },
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
}
