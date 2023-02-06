import 'package:alpha_web/Screens/QR_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

class homescreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return homescreenstate();
  }
}

class homescreenstate extends State<homescreen>{

   InAppWebViewController? webViewController;
   PullToRefreshController? refreshController;
   late var url;
   double progress = 0;
   var initurl = "https://www.google.co.in/";
   var urlController = TextEditingController();

   @override

   void initState(){
     super.initState();
     refreshController = PullToRefreshController(
       options: PullToRefreshOptions(
         color: Colors.black
       ),
       onRefresh: (){
         webViewController!.reload();
       }
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()async{
              if(await webViewController!.canGoBack()){
                webViewController!.goBack();
              }
            } ,
            icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal:4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: urlController,
            onSubmitted: (value){
              url = Uri.parse(value);
              if(url.scheme.isEmpty){
                url = Uri.parse("${initurl}search?q=$value");
              }
              webViewController!.loadUrl(urlRequest: URLRequest(url: url));
            } ,
            decoration: InputDecoration(
              hintText: 'Google',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed:(){
                webViewController!.reload();
              },
              icon: Icon(Icons.refresh_rounded,color: Colors.red,)
          ),
          IconButton(
              onPressed: () async{
                var a = urlController.text.toString();
                await Share.share('$a');
              },
              icon: Icon(Icons.share_rounded , color: Colors.green,) ),
          IconButton(
              onPressed:(){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => scanner()));
              },
              icon: Icon(Icons.qr_code_scanner_rounded, color: Colors.blue,)
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    onLoadStart:  (webViewController , url){
                      var v = url.toString();
                      setState(() {
                        urlController.text = v;
                      });
                    },
                    onLoadStop: (webViewController , url){
                      refreshController!.endRefreshing();
                    },
                    pullToRefreshController: refreshController,
                    onWebViewCreated: (controller)=> webViewController = controller,
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(initurl),
                    ) ,
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}
