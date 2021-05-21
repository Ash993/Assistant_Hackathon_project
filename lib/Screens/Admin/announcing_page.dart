import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:helpingwidget/Screens/Admin/bugreports_page.dart';

class Announcing extends StatefulWidget {
  @override
  _AnnouncingState createState() => _AnnouncingState();
}

class _AnnouncingState extends State<Announcing> {
  int _page=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          popupSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: annouce(context),
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
          onTap: (index) {
            //setState(() {_page = index;});
            _page = index;
            if (_page == 1) {
               launch("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a66895828dca000e59d32a");
            }
            if (_page == 2) {
              launch("https://console.wiredash.io/project/airbus-assistant-zthqbed/feedback/60a668ad828dca000e59d32b");
            }
            // if (_page == 3) {
            //   return Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => Involve()),
            //   );
            // }
          },

        ),
    );
  }
  
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


  void popupSheet(context) {
    TextEditingController title = TextEditingController();
    TextEditingController body = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Add Announcement'),
          insetPadding: EdgeInsets.symmetric(horizontal: 0),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              Divider(),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: body,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Body',
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                updateAnnocement(title.text, body.text);
                Navigator.of(context).pop();
              },
              child: Text('post'),
            ),
          ],
        ));
  }

  Future updateAnnocement(title, body) async {
    body=body.replaceAll("\n","");
    String link = "airbushack-default-rtdb.firebaseio.com";
    await http.post(Uri.https(link, "/announcs/.json"),
        body: '{"Heading":"$title","body":"$body"}');
    print("Announced");
    setState(() {

    });
  }

  Future deleteAnnocement(id) async {
    String link = "airbushack-default-rtdb.firebaseio.com";
    await http.delete(Uri.https(link, "/announcs/" + id + "/.json"));
    print("deleted");
    setState(() {

    });
  }

  Future getAnnocement() async {
    String link = "airbushack-default-rtdb.firebaseio.com";
    var res = await http.get(Uri.https(link, "/announcs/.json"));
    print("getted");
    var data = [];
    var temp = json.decode(res.body);
    temp.forEach((k, v) => data.add([k, v["Heading"], v["body"]]));
    return List.from(data.reversed);
  }

  Widget annouce(context) {
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
            } else if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listTile(snapshot, index, context);
                      }));
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget listTile(snapshot, index, context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5)),
      ),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(snapshot.data[index][1]),
        leading: Icon(Icons.notifications_active),
        trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
          deleteAnnocement(snapshot.data[index][0]);
        },),
        subtitle: snapshot.data[index][2].length<30?Text(snapshot.data[index][2]):Text(snapshot.data[index][2].substring(0, 30)+"...."),
        onTap: () {
          popupSheet1(context,snapshot.data[index][1],snapshot.data[index][2]);
        },
      ),
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
