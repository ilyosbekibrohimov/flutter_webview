import 'example2_js_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text("Current url ${url}"),),
            Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(
                  value: progress,
                )
                    : Container()),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  child: InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(
                            "https://onething.weeknday.com/",
                          )),
                      initialOptions: InAppWebViewGroupOptions(
                          crossPlatform:
                          InAppWebViewOptions(javaScriptEnabled: true)),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      onLoadStart: (InAppWebViewController controller,  Uri url) {
                        setState(() {
                          this.url = url.toString();
                          print("Hello  this is URL:${this.url}");
                        });
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      }),
                )),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.goBack();
                    }
                  },
                  child: Icon(Icons.arrow_back),
                ),
                MaterialButton(
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.goForward();
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
                MaterialButton(
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.reload();
                    }
                  },
                  child: Icon(Icons.refresh),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => Example2() ) );
                  },
                  child: Icon(Icons.navigate_next),
                ),
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
