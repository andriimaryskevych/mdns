import 'dart:async';
import 'package:mdns_plugin/mdns_plugin.dart';

typedef void MDNSPluginFunction (MDNSService service);

class Delegate implements MDNSPluginDelegate {
  final MDNSPluginFunction _onServiceDiscovered;

  Delegate (this._onServiceDiscovered);

  void onDiscoveryStarted() {}
  void onDiscoveryStopped() {}
  bool onServiceFound(MDNSService service) => true;
  void onServiceResolved(MDNSService service) { _onServiceDiscovered(service); }
  void onServiceUpdated(MDNSService service) {}
  void onServiceRemoved(MDNSService service) {}
}

class NetworkServiceDiscoveryService {
  String _serviceName;
  MDNSPlugin _plugin;
  Completer<MDNSService> _completer;

  NetworkServiceDiscoveryService(this._serviceName) {
    _plugin = MDNSPlugin(Delegate(_onServiceDiscovered));
    _completer = Completer();
  }

  Future<MDNSService> discover () {
    _plugin.startDiscovery(_serviceName);

    return _completer.future;
  }

  void _onServiceDiscovered (MDNSService serivce) {
    _completer.complete(serivce);
  }
}