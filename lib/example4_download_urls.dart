import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Example4 extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Example4> {
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
                onReceivedServerTrustAuthRequest: (contoller,  challenge) async{return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);},
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf")),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true, useOnDownloadStart: true),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onDownloadStart: (controller, Uri url) async {
                  print("onDownloadStart $url");
                  final taskId = await FlutterDownloader.enqueue(
                      url: url.toString(),
                      savedDir: (await getExternalStorageDirectory()).path,
                      showNotification: true,
                      // show download progress in status bar (for Android)
                      openFileFromNotification: true,
                      fileName: "Sample download"
                      // click on notification to open downloaded file (for Android)
                      );

                  print(taskId);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
