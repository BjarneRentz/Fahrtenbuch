import 'dart:collection';

import 'package:fahrtenbuch/models/ride.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';

class RideProvider extends ChangeNotifier {
  RideProvider() {
    loadRides();
  }

  final List<Ride> _rides = [];

  Ride? get unfinishedRide => _rides.firstWhereOrNull((ride) => !ride.finished);

  bool get hasUnfinishedRides => unfinishedRide != null;

  UnmodifiableListView<Ride> get rides => UnmodifiableListView(_rides);

  var _box = Hive.box<Ride>('rides');

  void add(Ride ride) {
    _rides.add(ride);
    _rides.sort((a, b) => b.date.compareTo(a.date));
    _box.add(ride);
    notifyListeners();
  }

  void remove(Ride ride) {
    _rides.remove(ride);
    _box.delete(ride.key);
    notifyListeners();
  }

  void loadRides() {
    _rides.clear();
    _rides.addAll(_box.values);
  }

  void updateRide(Ride ride) {
    _rides.removeWhere((r) => r.key == ride.key);
    _box.delete(ride.key);
    add(ride);
    notifyListeners();
  }
}
