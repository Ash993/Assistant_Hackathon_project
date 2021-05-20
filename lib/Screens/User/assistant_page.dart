import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/User/announcements_page.dart';
import 'package:helpingwidget/Screens/User/bugreporting_page.dart';
import 'package:helpingwidget/Screens/User/chatbot_page.dart';
import 'package:helpingwidget/Screens/User/community_page.dart';
import 'package:helpingwidget/Screens/User/livefeedback_page.dart';

class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  @override
  int _page = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Assistance'),
      ),
      body: Scaffold(

        bottomNavigationBar: CupertinoTabBar(

          currentIndex: _page,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt,
                color: (_page == 0) ? Colors.black : Colors.grey,
              ),
              title: new Text('User Community', style: TextStyle(color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headset_mic,
                color: (_page == 1) ? Colors.black : Colors.grey,

              ),
              title: new Text('Chatbot', style: TextStyle(color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bug_report_outlined,
                color: (_page == 2) ? Colors.black : Colors.grey,

              ),
              title: new Text('Bug Reporting', style: TextStyle(color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement,
                color: (_page == 3) ? Colors.black : Colors.grey,

              ),
              title: new Text('Announcements', style: TextStyle(
                  color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed,
                color: (_page == 4) ? Colors.black : Colors.grey,

              ),
              title: new Text('Live Feedback', style: TextStyle(color: Colors.black87,
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
                MaterialPageRoute(builder: (context) => UserCommunity()),
              );
            }
            if (_page == 1) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatBot()),
              );
            }
            if (_page == 2) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => BugReporting()),
              );
            }
            if (_page == 3) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => Announcements()),
              );
            }
            if (_page == 4) {
              return Navigator.push(context,
                MaterialPageRoute(builder: (context) => LiveFeedback()),
              );
            }
          },

        ),
      ),
    );
  }
}
