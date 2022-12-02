import 'package:fahrtenbuch/app.dart';
import 'package:fahrtenbuch/models/ride.dart';
import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Ride>(RideAdapter());
  await Hive.openBox<Ride>('rides');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => RideProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fahrtenbuch',
      theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
          useMaterial3: true),
      home: App(),
    );
  }
}
