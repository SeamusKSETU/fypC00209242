import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const MethodChannel _macChannel = MethodChannel('get_mac');
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAC Finder',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Mac(),
    );
  }
}
*/
class Mac extends StatefulWidget {
  const Mac({Key? key}) : super(key: key);

  @override
  State<Mac> createState() => _MacState();
}

class _MacState extends State<Mac> {
  String _deviceMAC = 'Click the button.';
  // Platform messages are async in nature
  // that's why we made a async function.
  Future<void> initMacAddress() async {
    String macAddress;

    try {
        macAddress = await _macChannel.invokeMethod<String>('getMacAddress') ??
          'MAC address unavailable.';
    } on PlatformException {
      macAddress = 'Error getting the MAC address.';
    }

    setState(() {
      _deviceMAC = macAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAC address of a device'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _deviceMAC,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                initMacAddress();
              },
              child: const Text("Get MAC Address"),
            ),
          ],
        ),
      ),
    );
  }
}