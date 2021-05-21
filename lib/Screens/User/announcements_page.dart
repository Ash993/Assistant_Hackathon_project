import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Announcements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: annouce(context),
    );
  }

  Future getAnnocement() async {
    String link = "airbushack-default-rtdb.firebaseio.com";
    var res = await http.get(Uri.https(link, "/announcs/.json"));
    print("getted");
    var data = [];
    var temp = json.decode(res.body);
    temp.forEach((k, v) => data.add([k, v["Heading"], v["body"]]));
    return List.from(data.reversed);;
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
              // if we got our data
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
