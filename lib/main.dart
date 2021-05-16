import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
// import 'package:bluetooth/bluetooth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// OTP.generateTOTPCodeString("JBSWY3DPEHPK3PXP", 1362302550000);  -> '637305'

class _MyHomePageState extends State<MyHomePage> {
  String otpCode = "CODIGOS";
  List spots = [
    'JBSWY3DPEHPK3PXP',
    'JBSWY3DPEHPK3PXN',
    'JBSWY3DPEHPK3PXM',
    'JBSWY3DPEHPK3PXO',
    'JBSWY3DPEHPK3PXZ',
  ];

  //instancia de FlutterBlue
  // FlutterBlue flutterBlue = FlutterBlue.instance;
  String devicesT = "Lista de dispositivos";
  List devices = [];
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('prueba bluetooth'),
        centerTitle: true,
        elevation: 10,
        leading: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              print(isSwitched);
            });
            if (isSwitched) {
              print('hello');
            }
          },
          activeTrackColor: Colors.yellow,
          activeColor: Colors.orangeAccent,
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20)),
            Container(
              color: Colors.black,
              width: 300,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    otpCode,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              devicesT,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          otpGEN().listen((event) {
            setState(() {
              otpCode = event;
            });
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.lock),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Stream<String> otpGEN() async* {
    for (var i = 0; i < spots.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      String tempCode = OTP.generateTOTPCodeString(spots[i], 1362302550000);
      String code = tempCode;
      yield code;
    }
  }
}
