// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class CustomUrls extends StatefulWidget {
//   const CustomUrls({Key key}) : super(key: key);
//
//   @override
//   _CustomUrlsState createState() => _CustomUrlsState();
// }
//
// class _CustomUrlsState extends State<CustomUrls> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: InAppWebView(
//           initialOptions: InAppWebViewGroupOptions(
//             crossPlatform: InAppWebViewOptions(
//                 javaScriptEnabled: true,
//                 useShouldOverrideUrlLoading: true
//             ),
//           ),
//           shouldOverrideUrlLoading: (controller, request) async {
//             var uri = request.request.url;
//
//             if (!["http", "https", "file",
//               "chrome", "data", "javascript",
//               "about"].contains(uri.scheme)) {
//               if (await canLaunch(url)) {
//                 // Launch the App
//                 await launch(
//                   url,
//                 );
//                 // and cancel the request
//                 return ShouldOverrideUrlLoadingAction.CANCEL;
//               }
//             }
//
//             return ShouldOverrideUrlLoadingAction.ALLOW;
//           },
//         ),
//       ),
//     );
//   }
// }
