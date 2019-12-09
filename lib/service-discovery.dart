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
  MDNSPlugin _plugin;
  Completer<MDNSService> _completer;
  Timer timer;

  NetworkServiceDiscoveryService() {
    _plugin = MDNSPlugin(Delegate(_onServiceDiscovered));
    _completer = Completer();
  }

  Future<MDNSService> discover (String service) {
    _plugin.startDiscovery(service);

    timer = Timer(Duration(seconds: 2), () => _resolveWithError(TimeoutException('Discovery timeout')));

    return _completer.future;
  }

  void _onServiceDiscovered (MDNSService serivce) {
    _resolveWithData(serivce);
  }

  void _resolveWithData (MDNSService serivce) {
    if (_completer.isCompleted) return;
    _plugin.stopDiscovery();
    timer.cancel();

    _completer.complete(serivce);
  }

  void _resolveWithError (Exception error) {
    if (_completer.isCompleted) return;
    _plugin.stopDiscovery();
    timer.cancel();

    _completer.completeError(error);
  }
}