// @dart=2.9
// ^ Removes checks for null safety
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import './common.dart';
import './theme.dart';

final standardAppBar = AppBar(
  bottomOpacity: 0.0,
  elevation: 0.0,
  toolbarOpacity: 1.0,
  // Red foreground
  backgroundColor: lightMainColor,
);

// UI String constants
const String kNoIoTDevicesFound = 'Engin snjalltæki fundin';
const String kFindDevices = "Finna snjalltæki";

const List<String> kDeviceTypes = <String>["Öll tæki", "Ljós", "Gardínur"];

// List of IoT widgets
List<Widget> _iot(BuildContext context) {
  return <Widget>[
    Container(
      margin: const EdgeInsets.only(left: 25.0, bottom: 80.0),
      child: const Text(
        "Embla snjallheimili",
        style: TextStyle(fontSize: 25.0, color: Colors.black),
      ),
    ),
    Center(
        child: Column(
      children: <Widget>[
        DropdownButton(
            items: kDeviceTypes.map<DropdownMenuItem<String>>((String s) {
              return DropdownMenuItem<String>(value: s, child: Text(s));
            }).toList(),
            onChanged: (String val) {
              dlog(val);
            }),
        const Text("herna koma eh tæki"),
        const Text("herna koma eh tæki"),
        const Text("herna koma eh tæki"),
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
