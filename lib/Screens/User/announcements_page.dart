import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:helpingwidget/Screens/User/chatbot_page.dart';
import 'package:wiredash/wiredash.dart';
import 'package:helpingwidget/shared/const.dart';


class MyTranslation extends WiredashTranslationData {
  String get feedbackModeBugTitle => 'Bug Reporting';
}

class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  @override
  final _navigatorKey = GlobalKey<NavigatorState>();

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
        home: Announcements(),
      ),
    );
  }
}
class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  
  bool clicked = false;
  int _page = 2;
  var datar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  IconButton(onPressed: (){
                    setState(() {
                      this.datar=null;
                    });
                  }, icon: Icon(Icons.refresh))],
      ),
      body: assist(context),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.headset_mic,
                color: (_page == 0) ? Colors.black : Colors.grey,
              ),
              title: new Text(
                'Chatbot',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bug_report_outlined,
                color: (_page == 1) ? Colors.black : Colors.grey,
              ),
              title: new Text(
                'Bug Reporting & Feedbacks',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.announcement,
                color: (_page == 2) ? Colors.black : Colors.grey,
              ),
              title: new Text(
                'Announcements',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatDetailPage()),
              );
            }
            else if (index == 1) {
              _features();
            }
          },
        ),
        
    );
  }

  void _features() {
    setState(() {});
    Wiredash.of(context).setOptions(appVersion: "1.1", userEmail: "pro@gmail.com", userId: "12345");
    Wiredash.of(context).show();
  }

  Future getAnnocement() async {
    String link = "airbushack-default-rtdb.firebaseio.com";
    var res = await http.get(Uri.https(link, "/announcs/.json"));
    print("getted");
    var data = [];
    var temp = json.decode(res.body);
    temp.forEach((k, v) => data.add([k, v["Heading"], v["body"]]));
    this.datar=List.from(data.reversed);
    return this.datar;
  }

  Widget annouce(context) {
    if (this.datar==null){
    return FutureBuilder(
        future: getAnnocement(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('${snapshot.error} occured');
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
              // if we got our data
            } else if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listTile(snapshot.data, index, context);
                      }));
            }
          }
          return Center(child: CircularProgressIndicator());
        });}
      else{
        return Container(
                  child: ListView.builder(
                      itemCount: this.datar.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listTile(this.datar, index, context);
                      }));
      }
  }

  Widget listTile(snapshot, index, context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5)),
      ),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(snapshot[index][1]),
        leading: Icon(Icons.notifications_active),
        subtitle: snapshot[index][2].length<30?Text(snapshot[index][2]):Text(snapshot[index][2].substring(0, 30)+"...."),
        onTap: () {
          popupSheet1(context,snapshot[index][1],snapshot[index][2]);
        },
      ),
    );
  }

  Widget assist(BuildContext context) {
    return Stack(
      children: [
        annouce(context),
        Positioned(
            bottom: 150,
            right: 5,
            child: RawMaterialButton(
              elevation: 2.0,
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              fillColor: Colors.purple,
              child: Icon(
                Icons.assistant_rounded,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (this.clicked)
                    this.clicked = false;
                  else
                    this.clicked = true;
                });
              },
            )),
        this.clicked
            ? Positioned(
                bottom: 240,
                right: 0,
                child: RawMaterialButton(
                  elevation: 2.0,
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.people_alt,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ))
            : Container(),
        this.clicked
            ? Positioned(
                bottom: 60,
                right: 0,
                child: RawMaterialButton(
                  elevation: 2.0,
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.dynamic_feed,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ))
            : Container(),
        this.clicked
            ? Positioned(
                bottom: 210,
                right: 60,
                child: RawMaterialButton(
                  elevation: 2.0,
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.headset_mic,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ))
            : Container(),
        this.clicked
            ? Positioned(
                bottom: 90,
                right: 60,
                child: RawMaterialButton(
                  elevation: 2.0,
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.announcement,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ))
            : Container(),
        this.clicked
            ? Positioned(
                bottom: 150,
                right: 80,
                child: RawMaterialButton(
                  elevation: 2.0,
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.bug_report_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ))
            : Container(),
      ],
    );
  }

  void popupSheet1(context,title,body) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ));
  }
}
