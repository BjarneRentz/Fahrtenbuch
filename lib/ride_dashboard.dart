import 'package:fahrtenbuch/animated_counter.dart';
import 'package:fahrtenbuch/no_data_card.dart';
import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/ride.dart';

class RideDashboard extends StatelessWidget {
  const RideDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(builder: (context, provider, child) {
      return provider.rides.isEmpty ? NoDataHint() : DashboardContent(provider);
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
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            AnimatedCounter(distanceSum),
            Text('Gefahrene Kilometer insgesamt')
          ],
        ),
      ),
    );
  }

  Map<DateTime, double> calculateMonthlyOverview() {
    var result = Map<DateTime, double>();

    return result;
  }
}
