import 'package:flutter/material.dart';
import 'package:mdns_plugin/mdns_plugin.dart';
import 'package:mdns/service-discovery.dart';

void main() => runApp(MyApp());

const String COORDINATOR_SERVICE_NAME = '_coordinator._tcp';

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

class _MyHomePageState extends State<MyHomePage> {
  List<String> items;

  @override
  void initState() {
    super.initState();

  }

  void initDiscovery() async {
    print('Started');

    try {
      List<MDNSService> services = await Future.wait([
        NetworkServiceDiscoveryService().discover(COORDINATOR_SERVICE_NAME),
        NetworkServiceDiscoveryService().discover(COORDINATOR_SERVICE_NAME)
      ]);

      // MDNSService service = await NetworkServiceDiscoveryService().discover(COORDINATOR_SERVICE_NAME);
      // MDNSService service1 = await NetworkServiceDiscoveryService().discover(COORDINATOR_SERVICE_NAME);

      print(services);
    } catch (Erorr) {
      print('Error');
    }

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