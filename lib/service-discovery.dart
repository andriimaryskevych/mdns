import 'dart:async';
import 'package:mdns_plugin/mdns_plugin.dart';

class Delegate implements MDNSPluginDelegate {
  Function _onServiceDiscovered;

  MDNSPluginDelegate (Function _onServiceDiscovered) {
    this._onServiceDiscovered = _onServiceDiscovered;
  }

  void onDiscoveryStarted() {}
  void onDiscoveryStopped() {}
  void onServiceUpdated(MDNSService service) {}
  void onServiceRemoved(MDNSService service) {}

  bool onServiceFound(MDNSService service) => true;
  void onServiceResolved(MDNSService service) {
      print("Resolved: $service");

      for (String address in service.addresses) {
        print(address);
      }
  }
}

class NetworkServiceDiscoveryService {
  String _serviceName;
  MDNSPlugin _plugin;
  Completer<String> _completer;

  NetworkServiceDiscoveryService(this._serviceName) {
    _plugin = MDNSPlugin(Delegate());
    _completer = Completer();
  }

  Future<String> discover () {
    _plugin.startDiscovery(_serviceName);

    return _completer.future;
  }

  void _onServiceDiscovered (MDNSService serive) {

  }
}