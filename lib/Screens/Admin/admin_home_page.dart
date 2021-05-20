import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/Admin/techteam_page.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            return Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TechTeam()));

          },
          child: Icon(Icons.assistant_rounded,),

        )
        ,
      ),
    );
  }
}

