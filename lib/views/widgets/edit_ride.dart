import 'package:fahrtenbuch/models/ride.dart';
import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditRide extends StatefulWidget {
  const EditRide(
      {Key? key,
      required this.rideProvider,
      this.ride,
      required this.onSubmittedCallback})
      : super(key: key);

  final Ride? ride;

  final RideProvider rideProvider;

  final Function onSubmittedCallback;

  @override
  _EditRideState createState() => _EditRideState(ride);
}

class _EditRideState extends State<EditRide> {
  _EditRideState(Ride? ride) {
    _ride = ride;
    if (ride != null) {
      _milageStart = (ride.mileageStart / 1000).toString();
      _description = ride.description;

      if (ride.milageEnd != null) {
        _milageEnd = (ride.milageEnd! / 1000).toString();
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  Ride? _ride;
  String _milageStart = '';
  String? _milageEnd;
  String _description = '';

  DateTime _date = DateTime.now();

  String formateDate(DateTime date) => DateFormat.yMMMd().format(date);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              InkWell(
                  child: Container(
                    color: Colors.blue[600],
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      formateDate(_date),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 365)),
                            lastDate: DateTime.now().add(Duration(days: 365)))
                        .then((date) {
                      if (date != null) {
                        setState(() {
                          this._date = date;
                        });
                      }
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => _milageStart = value,
                textInputAction: TextInputAction.next,
                initialValue: _milageStart,
                validator: (value) {
                  if (value == null || value.trim().length == 0) {
                    return 'Feld darf nicht leer sein';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Kilometerstand Start',
                    icon: Icon(Icons.directions),
                    border: OutlineInputBorder(),
                    suffixText: 'Km'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => _milageEnd = value,
                textInputAction: TextInputAction.next,
                initialValue: _milageEnd,
                validator: (value) {
                  if (_milageEnd != null) {
                    if (double.parse(_milageStart) >= double.parse(_milageEnd!))
                      return 'Gefahrene Kilometer dürfen nicht negativ sein';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Kilometerstand Ende',
                    icon: Icon(Icons.flag),
                    border: OutlineInputBorder(),
                    suffixText: 'Km'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) => _description = value,
                textInputAction: TextInputAction.done,
                initialValue: _description,
                onFieldSubmitted: (_) => _internalSubmit(),
                decoration: InputDecoration(
                  hintText: 'Beschreibung',
                  icon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => _internalSubmit(), child: Icon(Icons.check))
        ],
      ),
    );
  }

  void _internalSubmit() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }

    // User different handling wheather we edit or create a new Ride.
    if (_ride == null) {
      int milageStart = (double.parse(_milageStart) * 1000).toInt();
      int? milageEnd;
      if (_milageEnd != null)
        milageEnd = (double.parse(_milageEnd!) * 1000).toInt();

      Ride ride =
          Ride(_date, milageStart, milageEnd, description: _description);
      widget.rideProvider.add(ride);
    } else if (_ride != null) {
      _ride!.mileageStart = (double.parse(_milageStart) * 1000).toInt();
      if (_milageEnd != null)
        _ride!.milageEnd = (double.parse(_milageEnd!) * 1000).toInt();
      _ride!.description = _description;
      _ride!.date = _date;

      widget.rideProvider.updateRide(_ride!);
    }
    widget.onSubmittedCallback();
  }
}
