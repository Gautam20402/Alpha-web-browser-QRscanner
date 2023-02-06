import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';


class resultscreen extends StatelessWidget {

  final String code;
  final Function() closescreen;

  resultscreen({Key? key , required this.code , required this.closescreen}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              closescreen();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black,),
        centerTitle: true,
        title: Text('QR Scanner',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          QrImage(data: code,
          size: 120,
            version: QrVersions.auto,
          ),
          SizedBox(height: 10,),
          Text('Scanned result',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black45,
          ),),
          SizedBox(height: 10,),
          Text('$code',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),
          SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: 48,
            child: ElevatedButton(
                onPressed: (){
                  Clipboard.setData(ClipboardData(text: code));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
            child: Text('Copy',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              letterSpacing: 1,
            ),),),
          )
        ],
      ),),
    );
  }
}
