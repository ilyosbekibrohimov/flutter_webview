import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HandleCookies extends StatefulWidget {
  const HandleCookies({Key key}) : super(key: key);

  @override
  _HandleCookiesState createState() => _HandleCookiesState();
}

class _HandleCookiesState extends State<HandleCookies> {
  CookieManager _cookieManager = CookieManager.instance();
  final expireDate =
      DateTime.now().add(Duration(days: 3)).millisecondsSinceEpoch;
  final _url = "https://flutter.dev/";
  final _name = "session";
  final _value = "54th5hfdcfg34";
  final _domain = ".flutter.dev";

  @override
  Widget build(BuildContext context) {
    _cookieManager.setCookie(
        url: Uri.parse(_url),
        name: _name,
        value: _value,
        domain: _domain,
        expiresDate: expireDate,
        isSecure: true);

    return Container();
  }
}
