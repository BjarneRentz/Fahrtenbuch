import 'package:hive/hive.dart';
part 'ride.g.dart';

@HiveType(typeId: 0)
class Ride extends HiveObject {

 
  Ride(this.date, this.mileageStart, this.milageEnd, {this.description = ''});

  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int mileageStart;

  @HiveField(2)
  int milageEnd;

  @HiveField(3)
  String description ='';

  int get distance => milageEnd - mileageStart;
}