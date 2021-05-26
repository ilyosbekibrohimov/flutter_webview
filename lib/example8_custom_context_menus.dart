import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomContentExample extends StatefulWidget {
  const CustomContentExample({Key key}) : super(key: key);

  @override
  _CustomContentExampleState createState() => _CustomContentExampleState();
}

class _CustomContentExampleState extends State<CustomContentExample> {
  InAppWebViewController _webViewController;
  ContextMenu _contextMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contextMenu = ContextMenu(
        menuItems: [ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu Item  special clicked");
                var selectedText = _webViewController.getSelectedText();
                await _webViewController.clearFocus();
                await _webViewController.evaluateJavascript(
                    source: "window.alert('You have selected $selectedText')");
              })],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("OnCreateContextMenu");
          print(hitTestResult.extra);
          print(await _webViewController.getSelectedText());
        },
        onHideContextMenu: () {
          print("OnHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(child: Container(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse("https://github.com/flutter")),
              contextMenu: _contextMenu,
              initialOptions: InAppWebViewGroupOptions(
                 crossPlatform: InAppWebViewOptions(
                   javaScriptEnabled: true
                 )
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                 _webViewController = controller;
              },
            ),
          ))
        ],
      ),
    );
  }
}
