// @dart=2.9
// ^ Removes checks for null safety
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import './common.dart';
import './theme.dart';
import './mdns.dart';
import './connection_card.dart';
import './connection.dart';

// UI String constants
const String kNoIoTDevicesFound = 'Engin snjalltæki fundin';
const String kFindDevices = "Finna snjalltæki";

const List<String> kDeviceTypes = <String>["Öll tæki", "Ljós", "Gardínur"];

// List of IoT widgets
List<Widget> _iot(BuildContext context) {
  MulticastDNSSearcher mdns = MulticastDNSSearcher();

  mdns.findLocalDevices(kmDNSServiceFilters, (String x) {
    dlog("CALLBACK: Found device $x");
  });

  dlog("Context: , $context");
  return <Widget>[
    Container(
      margin: const EdgeInsets.only(top: 20.0, left: 25.0, bottom: 30.0),
      child: const Text(
        "Embla snjallheimili",
        style: TextStyle(fontSize: 25.0, color: Colors.black),
      ),
    ),
    Container(
      margin: const EdgeInsets.only(left: 25.0, bottom: 20.0),
      child: Text(
        'Tækin mín',
        style: Theme.of(context).textTheme.headline4,
      ),
    ),
    Center(
        child: Column(
      children: <Widget>[
        // DropdownButton(
        //     items: kDeviceTypes.map<DropdownMenuItem<String>>((String s) {
        //       return DropdownMenuItem<String>(value: s, child: Text(s));
        //     }).toList(),
        //     onChanged: (String val) {
        //       dlog(val);
        //     }),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            ConnectionCard(
              connection: Connection(
                name: 'Hue Hub',
                brand: 'Philips',
                icon: Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
              ),
            ),
            ConnectionCard(
              connection: Connection(
                name: 'Home Smart',
                brand: 'Ikea',
                icon: Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30.0, // TODO: Make this dynamic
                ),
              ),
            ),
            ConnectionCard(
              connection: Connection(
                name: 'Sonos',
                brand: 'Sonos, Inc.',
                icon: Icon(
                  Icons.speaker_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
              ),
            ),
            ConnectionCard(
              connection: Connection(
                name: 'Shelly',
                brand: 'Shelly, Inc.',
                icon: Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
              ),
            ),
            ConnectionCard(
              connection: Connection(
                name: 'Spotify',
                brand: 'Spotify Technologies S.A.',
                icon: Icon(
                  Icons.music_note_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
        // TODO: Add widget for filtering connected devices (dropdown?)
        // TODO: Add widget for connected devices
        // TODO: Add widget for going into "Tengja snjalltæki"
      ],
    )),
  ];
}

class IoTRoute extends StatelessWidget {
  const IoTRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> wlist = _iot(context);

    return Scaffold(
        appBar: standardAppBar,
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: wlist,
        ));
  }
}

class EmblaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightThemeData,
      dark: darkThemeData,
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: kSoftwareName,
        theme: theme,
        darkTheme: darkTheme,
        home: IoTRoute(),
      ),
    );
  }
}

void main() => runApp(EmblaApp());
