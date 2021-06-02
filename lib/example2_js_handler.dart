import 'package:flutter/material.dart';
import 'package:flutter_webview/example3_webrtc.dart';
import 'package:flutter_webview/example4_download_urls.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'example5_popup_windows.dart';
import 'example8_custom_context_menus.dart';

class Example2 extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Example2> {
  InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialData: InAppWebViewInitialData(data: """
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body>
    
    
 
        <h1 onclick="myFunction()">JavaScript Handlers (Channels) TEST</h1>
        <script>
        
         var isFlutterInAppWebViewReady = false;
           window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
            isFlutterInAppWebViewReady = true;
               });
               
               
           function myFunction(){
         
         
             if(isFlutterInAppWebViewReady){
               const args = [1, true, ['bar', 5], {foo: 'baz'}];
 window.flutter_inappwebview.callHandler('handlerFoo', ...args);
             }
               
               
          
           
          
    
          }
           
            
            
        </script>
    </body>
</html>
                  """),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;



              },
              onLoadStop: (InAppWebViewController controller, Uri uri) {
                 _webViewController = controller;
                 _webViewController.addJavaScriptHandler(
                     handlerName: 'handlerFoo',
                     callback: (args) {
                       // return data to JavaScript side!
                       test();
                       return {'bar': 'bar_value', 'baz': 'baz_value'};
                     });
                 _webViewController.addJavaScriptHandler(
                     handlerName: 'handlerFooWithArgs',
                     callback: (args) {
                       print(args);
                       // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                     });

              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
                // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
              },
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WebRTC()));
                },
                child: Text("WebRTC"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Example4()));
                },
                child: Text("download"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InAppWebViewExample5()));
                },
                child: Text("popup"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomContentExample()));
                },
                child: Text("menu"),
              )
            ],
          )
        ])),
      ),
    );
  }

  void test() {
    print("Ilyosbek");
  }

}
