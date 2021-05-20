import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/User/announcements_page.dart';
import 'package:helpingwidget/Screens/User/bugreporting_page.dart';
import 'package:helpingwidget/Screens/User/chatbot_page.dart';
import 'package:helpingwidget/Screens/User/community_page.dart';
import 'package:helpingwidget/Screens/User/livefeedback_page.dart';
import 'package:helpingwidget/shared/const.dart';
import 'package:wiredash/wiredash.dart';
class MyTranslation extends WiredashTranslationData{
  String get feedbackModeBugTitle => 'Bug Reporting';
}
class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {

  @override

  final _navigatorKey =GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return Wiredash(
      navigatorKey: _navigatorKey,
      theme: WiredashThemeData(
        primaryColor: Colors.blueAccent,
        secondaryColor: Colors.orangeAccent,
        dividerColor: Colors.blue,
        primaryBackgroundColor: Colors.greenAccent,
      ),
      projectId: projectID,
      secret: secretKey,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Assistant',
        home: MyHomePage(title: 'Assistant'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;

  void _features(){
    setState(() {

    });
    Wiredash.of(context).setOptions(appVersion: "1.1",userEmail: "pro@gmail.com",userId: "12345");
    Wiredash.of(context).show();

  }
  @override
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _features,
        ),
      ),
    );

  }
}
