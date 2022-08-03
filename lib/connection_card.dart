// @dart=2.9
// ^ Removes checks for null safety
import 'package:flutter/material.dart';
import 'package:iotembla/common.dart';
import './connection.dart';

// TODO: Maybe not stateful?
class ConnectionCard extends StatefulWidget {
  final Connection connection;

  const ConnectionCard({Key key, this.connection}) : super(key: key);

  @override
  _ConnectionCardState createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(width);
    var cardWidth = (width < 500.0) ? (width * 0.35) : (width * 0.175);

    return GestureDetector(
      onTap: () {
        setState(() {
          counter++;
        });
        dlog("Counter: $counter");
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: SizedBox(
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.connection.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.connection.brand,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  //style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: widget.connection.icon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
