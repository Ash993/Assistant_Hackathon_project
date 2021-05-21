import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/cupertino.dart';


class BugHomePage extends StatefulWidget {
  @override
  _BugHomePageState createState() => _BugHomePageState();
}

class _BugHomePageState extends State<BugHomePage> {
  var isLoading=true;
  var _page=1;
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
              initialUrlRequest: URLRequest(url: Uri.parse("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a66895828dca000e59d32a"),headers:{"userAgent": "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/20100101 Firefox/4.0"}),
            ),
            //isLoading ? Center( child: CircularProgressIndicator(),): Container(),
          ],
        ),
      bottomNavigationBar: CupertinoTabBar(

          currentIndex: _page,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement,
                color: (_page == 0) ? Colors.black : Colors.grey,
              ),
              title: new Text('Announcements', style: TextStyle(color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bug_report_sharp,
                color: (_page == 1) ? Colors.black : Colors.grey,

              ),
              title: new Text('Bug Reports', style: TextStyle(color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed_rounded,
                color: (_page == 2) ? Colors.black : Colors.grey,

              ),
              title: new Text('Live Feedback', style: TextStyle(color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),

          ],
      ),
    ));
  }
}
