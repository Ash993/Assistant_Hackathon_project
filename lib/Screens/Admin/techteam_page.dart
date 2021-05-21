import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/Admin/announcing_page.dart';
import 'package:helpingwidget/Screens/Admin/bugreports_page.dart';
import 'package:helpingwidget/Screens/Admin/involve_page.dart';
import 'package:helpingwidget/Screens/Admin/livefeedback_page.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart';


class TechTeam extends StatefulWidget {
  @override
  _TechTeamState createState() => _TechTeamState();
}

class _TechTeamState extends State<TechTeam> {

  openURL() async{
    if(await canLaunch("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a66895828dca000e59d32a")){
      await launch("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a66895828dca000e59d32a");

    }else{
      throw 'Could Not Launch URL';
    }
  }
  openURL2() async{
    if(await canLaunch("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a668ad828dca000e59d32b")){
      await launch("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a668ad828dca000e59d32b");

    }else{
      throw 'Could Not Launch URL';
    }
  }

  @override
  int _page=0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technical Team'),
      ),
      body: Scaffold(


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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.chat_rounded,
            //     color: (_page == 3) ? Colors.black : Colors.grey,
            //
            //   ),
            //   title: new Text('Involve', style: TextStyle(
            //       color: Colors.black87,
            //       fontSize: 11.0,
            //       fontWeight: FontWeight.bold),),
            //   backgroundColor: Colors.white,
            // ),

          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
            if (_page == 0) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => Announcing()),
              );
            }
            if (_page == 1) {
              openURL();
            }
            if (_page == 2) {
              openURL2();
            }
            // if (_page == 3) {
            //   return Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => Involve()),
            //   );
            // }
          },

        ),
      ),
    );
  }
}
