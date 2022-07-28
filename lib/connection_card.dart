import 'package:flutter/material.dart';
import 'package:iotembla/common.dart';
import './theme.dart';

// TODO: Maybe not stateful?
class ConnectionCard extends StatefulWidget {
  @override
  _ConnectionCardState createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          counter++;
        });
        dlog("Counter: $counter");
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: SizedBox(
            width: 150,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hue Hub',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Philips',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.lightbulb_outline_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
