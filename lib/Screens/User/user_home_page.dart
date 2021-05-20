import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/User/assistant_page.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home Page'),
      ),
      body: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            return Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Assistant()));

          },
          child: Icon(Icons.assistant_rounded,),

        )
        ,
      ),
    );
  }
}
