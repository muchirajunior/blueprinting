import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown)
      ),
      home: const Home(),
    );
  }

}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BluetoothInfo> devices = [];

  showSnackbar(String message)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

 getDevices()async{
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    showSnackbar("connection result $result");
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;
    await Future.forEach(listResult, (BluetoothInfo bluetooth) {
      String mac = bluetooth.macAdress;
      devices.add(bluetooth);
      print(mac);
    });
    setState(() { });
 }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Blue"),
        elevation: 2,
      ),

      body: RefreshIndicator(
        onRefresh:()=>getDevices(),
        child: ListView(
          children: devices.map((device) => Card(
            child: ListTile(
              title: Text(device.name),
              onTap: ()async{
                var result =await PrintBluetoothThermal.connect(macPrinterAddress: device.macAdress);
                showSnackbar(result.toString());
                
                var res = await PrintBluetoothThermal.writeString(printText:  PrintTextSize(size: 20, text:  "Hello \n \t there this is just a sample \n Thank you \n\n \n"));
                showSnackbar(res.toString());
                
                await PrintBluetoothThermal.disconnect;
              },
            ),
          )).toList(),
        ),
        ),

    );
  }
}
