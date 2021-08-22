import 'package:flutter/material.dart';

class NoDataHint extends StatelessWidget {
  const NoDataHint({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text('Noch keine Fahrten erfasst'),),);
  }
}