import 'package:fahrtenbuch/no_data_card.dart';
import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:fahrtenbuch/ride_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideOverview extends StatelessWidget {
  const RideOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(
      builder: (context, provider, child) => Container(
          padding: EdgeInsets.all(16.0),
          child: provider.rides.isEmpty ? NoDataHint() : RideList(provider)),
    );
  }
}
