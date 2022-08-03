/*
 * This file is part of the Embla Flutter app
 * Copyright (c) 2020-2022 Miðeind ehf. <mideind@mideind.is>
 * Original author: Sveinbjorn Thordarson
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// mDNS scan route

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';

import './theme.dart';
import 'connection.dart';
import 'connection_card.dart';

// UI String constants
const String kNoIoTDevicesFound = 'Engin snjalltæki fundin';
const String kFindDevices = "Finna snjalltæki";

// List of IoT widgets
List<Widget> _mdns(BuildContext context) {
  List<ConnectionCard> connectionCards = <ConnectionCard>[
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
  ];

  return <Widget>[
    Container(
        margin: const EdgeInsets.only(
            top: 20.0, left: 25.0, bottom: 30.0, right: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Tækjaleit",
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
          ],
        )),
    Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(),
          child: const Text(
            'Skanna',
          ),
        ),
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
          children: connectionCards.map((card) {
            return card;
          }).toList(),
        ),
        // TODO: Add widget for filtering connected devices (dropdown?)
        // TODO: Add widget for connected devices
        // TODO: Add widget for going into "Tengja snjalltæki"
      ],
    )),
  ];
  // TODO: Add widget for selecting specific devices
  // TODO: Add widget for found devices
  // TODO: Add widget for activating mDNS search (and spinner)
}

class MDNSRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> wlist = _mdns(context);

    if (kReleaseMode == false) {
      // Special debug widgets go here
    }

    return Scaffold(
      appBar: standardAppBar,
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: wlist,
      ),
    );
  }
}
