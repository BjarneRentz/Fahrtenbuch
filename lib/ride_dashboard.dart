import 'package:fahrtenbuch/animated_counter.dart';
import 'package:fahrtenbuch/no_data_card.dart';
import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/ride.dart';

class RideDashboard extends StatelessWidget {
  const RideDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(builder: (context, provider, child) {
      return Padding(
          padding: const EdgeInsets.all(16),
          child: provider.rides.isEmpty
              ? NoDataHint()
              : DashboardContent(provider));
    });
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent(this.provider, {Key? key}) : super(key: key);

  final RideProvider provider;

  @override
  Widget build(BuildContext context) {
    double distanceSum = provider.rides
            .map((e) => e.distance)
            .reduce((value, element) => value + element) /
        1000;
    print(distanceSum);
    return Container(
      child: Center(
        child: Column(
          children: [
            AnimatedCounter(distanceSum),
            Text('Gefahrene Kilometer insgesamt'),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: calculateMonthlyOverview(provider.rides)
                      .entries
                      .map<Widget>((entry) => Card(
                            child: ListTile(
                              title: Text(DateFormat.yMMMM().format(entry.key) +
                                  ' ' +
                                  entry.value.toString() +
                                  ' Km'),
                            ),
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map<DateTime, double> calculateMonthlyOverview(List<Ride> rides) {
    var result = Map<DateTime, double>();

    for (var ride in rides) {
      var monthDate = DateTime(ride.date.year, ride.date.month);
      if (result.containsKey(monthDate)) {
        result[monthDate] = (result[monthDate]! + (ride.distance / 1000));
      } else {
        result[monthDate] = ride.distance / 1000;
      }
    }
    return result;
  }
}
