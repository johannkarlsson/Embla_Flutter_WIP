// @dart=2.9
// ^ Removes checks for null safety
import 'dart:io';
import 'package:multicast_dns/multicast_dns.dart';
import './common.dart';

final List<RegExp> kmDNSServiceFilters = <RegExp>[
  RegExp(r"_hue._tcp.local"),
  RegExp(r"_sonos._tcp.local"),
];

/// Dataclass for storing information about a discovered device.
class MDNSDevice {
  String fqdn; // Fully qualified domain name
  String ip; // IP address
  int port; // Port
  MDNSDevice({this.fqdn, this.ip, this.port});
}

/// Singleton class for handling mDNS queries.
class MulticastDNSSearcher {
  // Singleton instance
  static final MulticastDNSSearcher _instance = MulticastDNSSearcher._internal();
  // Magic address for finding services on local network
  static const String _endpoint = '_services._dns-sd._udp.local';
  bool _searchInProgress = false;
  final MDnsClient _client;

  /// Factory constructor for creating a new instance of [MulticastDNSSearcher].
  factory MulticastDNSSearcher() {
    return _instance;
  }

  /// Private constructor for singleton class.
  /// Creates an MDnsClient (turn off reusePort, due to bug on some devices).
  MulticastDNSSearcher._internal()
      : _client = MDnsClient(
            rawDatagramSocketFactory: (
          dynamic host,
          int port, {
          bool reuseAddress,
          bool reusePort,
          int ttl,
        }) =>
                RawDatagramSocket.bind(host, port, reuseAddress: true, reusePort: false, ttl: ttl));

  // NULL SAFE VERSION
  //   final MDnsClient client = MDnsClient(rawDatagramSocketFactory:
  //     (dynamic host, int port,
  //         {bool? reuseAddress, bool? reusePort, int? ttl}) {
  //   return RawDatagramSocket.bind(host, port,
  //       reuseAddress: true, reusePort: false, ttl: ttl!);
  // });

  /// Finds all devices on the local network using mDNS.
  /// Calls deviceCallback for each found device that matches a filter regex.
  Future<void> findLocalDevices(List<RegExp> filters, Function deviceCallback) async {
    // Start the client with default options.
    while (_searchInProgress) {
      _client.stop();
      dlog("Search in progress, waiting...");
      await Future.delayed(const Duration(milliseconds: 10));
    }
    dlog("below while loop");
    _searchInProgress = true;
    await _client.start();
    dlog("Started mDNS client");
    try {
      // Get the PTR record for the service.
      await for (final PtrResourceRecord ptr
          in _client.lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(_endpoint))) {
        // Use the domainName from the PTR record to get the SRV record,
        // which will have the port and local hostname.
        // Note that duplicate messages may come through, especially if any
        // other mDNS queries are running elsewhere on the machine.
        dlog('>>>>>>>>>>>>>>> ${ptr.domainName}');
        dlog(ptr);
        await for (final PtrResourceRecord ptr2 in _client
            .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(ptr.domainName))) {
          dlog("!!!!!!!!!!!!!!! ${ptr2.domainName}");

          await for (final SrvResourceRecord srv
              in _client.lookup<SrvResourceRecord>(ResourceRecordQuery.service(ptr2.domainName))) {
            dlog('Something found at ${srv.target}:${srv.port} for "${srv.name}".');
            await for (final IPAddressResourceRecord ipa in _client
                .lookup<IPAddressResourceRecord>(ResourceRecordQuery.addressIPv4(srv.target))) {
              dlog('IP address is ${ipa.address.address}:${srv.port}');
              // Check if this device matches any of the filters.
              for (final RegExp filter in filters) {
                if (filter.hasMatch(srv.name)) {
                  dlog('Device matches filter "${filter.pattern}".');
                  // Call the callback with the device info.
                  deviceCallback(srv.name);
                }
              }
            }
          }
        }
      }
      dlog("Finished searching for devices");
      _client.stop();

      dlog('mDNS client stopped.');
    } on StateError {
      // Another search is starting, ignore this one.
      dlog("Cancelled the first search");
      
    } finally {
      dlog("SETTING SEARCH TO FALSE");
      _searchInProgress = false;
    }
  }
}
