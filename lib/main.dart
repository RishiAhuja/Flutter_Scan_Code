import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanit/result.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));
var qrText = '';
const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';
class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}
class HomePageState extends State<HomePage> {
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool camera = true;
  bool flash = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: BorderRadius.circular(12),
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Wrap(
                    children: [
                      NeumorphicTheme(
                        themeMode: ThemeMode.light,
                        // style: NeumorphicStyle(
                        //   intensity: 0,
                        //   color: Colors.blue
                        // ),
                        child: FlatButton(
                            onPressed: () {
                              if (controller != null) {
                                controller.flipCamera();
                                if (_isBackCamera(cameraState)) {
                                  setState(() {
                                    cameraState = frontCamera;
                                    camera = false;
                                  });
                                } else {
                                  setState(() {
                                    cameraState = backCamera;
                                    camera = true;
                                  });
                                }
                              }
                            },
                            child: camera ? Icon(Icons.camera_alt_outlined, color: Colors.white,) : SizedBox(height: 40,width: 40,child: Image.asset("assets/camera.png"))
                        ),
                      ),
                      VerticalDivider(color: Colors.white, thickness: 2,),
                      FlatButton(
                          onPressed: () {
                            if (controller != null) {
                              controller.toggleFlash();
                              if (_isFlashOn(flashState)) {
                                setState(() {
                                  flashState = flashOff;
                                  flash = false;
                                });
                              } else {
                                setState(() {
                                  flashState = flashOn;
                                  flash = true;
                                });
                              }
                            }
                          },
                          child: flash ? Icon(Icons.flash_on, color: Colors.white) : Icon(Icons.flash_off, color: Colors.white)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Result()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}