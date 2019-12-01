import 'package:flutter/material.dart';
import 'package:mdns_plugin/mdns_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Delegate implements MDNSPluginDelegate {
  void onDiscoveryStarted() {
      print("Discovery started");
  }
  void onDiscoveryStopped() {
      print("Discovery stopped");
  }
  bool onServiceFound(MDNSService service) {
      print("Found: $service");
      return true;
  }
  void onServiceResolved(MDNSService service) {
      print("Resolved: $service");

      for (String address in service.addresses) {
        print(address);
      }
  }
  void onServiceUpdated(MDNSService service) {
      print("Updated: $service");
  }
  void onServiceRemoved(MDNSService service) {
      print("Removed: $service");
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items;

  @override
  void initState() {
    super.initState();

  }

  void initDiscovery() async {
    MDNSPlugin mdns = new MDNSPlugin(Delegate());

    mdns.startDiscovery("_onboarding._tcp", enableUpdating: true);

    print('Called after');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Hello'),
      floatingActionButton: FloatingActionButton(
        onPressed: initDiscovery,
      ),
    );
  }
}