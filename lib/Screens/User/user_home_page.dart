import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/User/assistant_page.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  void initState(){
    super.initState();
    setupAlan();
  }
  setupAlan() {
    AlanVoice.addButton("4ccdd3fef76614d96e1cc06d3a33e1262e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT
    );
    // AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

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
