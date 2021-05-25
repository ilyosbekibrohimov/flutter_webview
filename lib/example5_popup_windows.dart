import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewExample5 extends StatefulWidget {
  const InAppWebViewExample5({Key key}) : super(key: key);

  @override
  _InAppWebViewExample5State createState() => _InAppWebViewExample5State();
}

class _InAppWebViewExample5State extends State<InAppWebViewExample5> {
  InAppWebViewController _webViewController;
  InAppWebViewController _webViewPopupController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poup example"),
      ),
      body: SafeArea(
        child: Container(
          child: InAppWebView(
            initialData: InAppWebViewInitialData(data: """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Flutter InAppWebView</title>
</head>
<body>
  <a style="margin: 50px; background: #333; color: #fff; font-weight: bold; font-size: 20px; padding: 15px; display: block;"
    href="https://github.com/flutter"
    target="_blank">
    Click here to open https://github.com/flutter in a popup!
  </a>
</body>
</html>
"""),
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    javaScriptEnabled: true,
                    javaScriptCanOpenWindowsAutomatically: true),
                android:
                    AndroidInAppWebViewOptions(supportMultipleWindows: true),
                ios: IOSInAppWebViewOptions(
                    // here you  can specify  ios specifci  features of  webview
                    )),
            onCreateWindow: (controller, createWindowRequest) async {
              print("Create  Window");
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: Container(
                      child: InAppWebView(
                        windowId: createWindowRequest.windowId,
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform:
                                InAppWebViewOptions(javaScriptEnabled: true)),
                        onWebViewCreated: (InAppWebViewController controller) {
                          _webViewPopupController = controller;
                        },
                        onLoadStart:
                            (InAppWebViewController controller, Uri uri) {
                          print("Loading ${uri.toString()}");
                        },
                        onLoadStop:
                            (InAppWebViewController controller, Uri uri) {
                          print("Stop  ${uri}");
                        },
                      ),
                    ));
                  });

              return true;
            },
          ),
        ),
      ),
    );
  }
}
