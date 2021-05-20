import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/Admin/announcing_page.dart';
import 'package:helpingwidget/Screens/Admin/bugreports_page.dart';
import 'package:helpingwidget/Screens/Admin/involve_page.dart';
import 'package:helpingwidget/Screens/Admin/livefeedback_page.dart';


class TechTeam extends StatefulWidget {
  @override
  _TechTeamState createState() => _TechTeamState();
}

class _TechTeamState extends State<TechTeam> {
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
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded,
                color: (_page == 3) ? Colors.black : Colors.grey,

              ),
              title: new Text('Involve', style: TextStyle(
                  color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),

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
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => BugReports()),
              );
            }
            if (_page == 2) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => LiveFeedbacks()),
              );
            }
            if (_page == 3) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => Involve()),
              );
            }
          },

        ),
      ),
    );
  }
}
