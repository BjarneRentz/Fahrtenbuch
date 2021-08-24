import 'package:fahrtenbuch/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/ride.dart';

class AddRide extends StatefulWidget {
  const AddRide({Key? key}) : super(key: key);

  @override
  _AddRideState createState() => _AddRideState();
}

class _AddRideState extends State<AddRide> {
  final _formKey = GlobalKey<FormState>();

  late String _milageStart;
  late String _milageEnd;
  String _description = '';

  DateTime _date = DateTime.now();

  String formateDate(DateTime date) => DateFormat.yMMMd().format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fahrt hinzufügen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                firstDate: DateTime.now()
                                    .subtract(Duration(days: 365)),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)))
                            .then((date) {
                          if (date != null) {
                            setState(() {
                              this._date = date;
                            });
                          }
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _milageStart = value,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().length == 0) {
                        return 'Feld darf nicht leer sein';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Kilometerstand Start',
                        icon: Icon(Icons.directions),
                        border: OutlineInputBorder(),
                        suffixText: 'Km'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _milageEnd = value,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().length == 0) {
                        return 'Feld darf nicht leer sein';
                      }
                      if (double.parse(_milageStart) >=
                          double.parse(_milageEnd))
                        return 'Gefahrene Kilometer dürfen nicht negativ sein';
                    },
                    decoration: InputDecoration(
                        hintText: 'Kilometerstand Ende',
                        icon: Icon(Icons.flag),
                        border: OutlineInputBorder(),
                        suffixText: 'Km'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) => _description = value,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => submitRide(),
                    decoration: InputDecoration(
                      hintText: 'Beschreibung',
                      icon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () => submitRide(), child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }

  void submitRide() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }

    int milageStart = (double.parse(_milageStart) * 1000).toInt();
    int milageEnd = (double.parse(_milageEnd) * 1000).toInt();

    Ride ride = Ride(_date, milageStart, milageEnd, description: _description);

    var rideProvider = Provider.of<RideProvider>(context, listen: false);
    rideProvider.add(ride);

    Navigator.pop(context);
  }
}
