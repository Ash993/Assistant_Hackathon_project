import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:helpingwidget/Screens/User/announcements_page.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var isLoading=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home Page'),
      ),
      body: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse("https://www.airbus.com/")),
            ),
            //isLoading ? Center( child: CircularProgressIndicator(),): Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () async {
            return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Assistant()),
              );
          },
          child: Icon(
            Icons.assistant_rounded,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
