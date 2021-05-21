import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Announcing extends StatefulWidget {
  @override
  _AnnouncingState createState() => _AnnouncingState();
}

class _AnnouncingState extends State<Announcing> {
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
    );
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
