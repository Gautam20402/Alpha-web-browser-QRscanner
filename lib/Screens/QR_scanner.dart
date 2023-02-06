
import 'package:flutter/material.dart';
import 'package:alpha_web/Screens/result_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';



class scanner extends StatefulWidget {


  @override
  State<scanner> createState() => _scannerState();
}

class _scannerState extends State<scanner> {

  bool scancomplete = false;
  bool flashon = false;
  bool frontcamera = false;

  MobileScannerController controller = MobileScannerController();

  void close(){
    scancomplete = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black,),
        actions: [
          IconButton(
              onPressed:(){
                setState(() {
                  flashon = !flashon;
                });
                controller.toggleTorch();
              },
              icon:Icon(Icons.flash_on, color: flashon ? Colors.amber : Colors.grey ,)),
          IconButton(
              onPressed:(){
                setState(() {
                  frontcamera = !frontcamera;
                });
                controller.switchCamera();
              },
              icon:Icon(Icons.cameraswitch_rounded, color: frontcamera ? Colors.blueAccent : Colors.grey ,))
        ],
        centerTitle: true,
        title: Text('QR Scanner',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Place the QR code in the area',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),),
                    SizedBox(height: 10,),
                    Text('Scanning will start automatically',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),)
                  ],
                ),
            ),
            Container(
              height: 300,
                width: 300,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                        allowDuplicates: true,
                        onDetect: (barcode,args){
                          if(!scancomplete){
                            String code = barcode.rawValue ?? '---';
                            scancomplete = true;
                            Navigator.push(
                                context, MaterialPageRoute(
                              builder: (context) => resultscreen(
                                closescreen: close,
                                code: code,
                              ),
                            )
                            );
                          }
                        }
                    ),
                    Overlay(

                    )
                  ],
                )
            ),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logo4.png"),
                    )
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
