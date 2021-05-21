import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpingwidget/shared/questions.dart';

enum MessageType { Sender, Receiver, typing }

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  ScrollController scrollController = new ScrollController();
  TextEditingController msg = TextEditingController();

  List<ChatMessage> chatMessage = [];

  Future updatemessage(mesg) async {}

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            controller: this.scrollController,
            itemCount: this.chatMessage.length+3,
            //shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            //physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              try{
                return ChatBubble(
                  chatMessage: this.chatMessage[index],
                );}
              catch(e){
                return Container(height: 30,);
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: msg,
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30, bottom: 50),
              child: FloatingActionButton(
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  chatMessage.add(
                    ChatMessage(message: msg.text, type: MessageType.Sender),
                  );
                  this.chatMessage.add(
                      ChatMessage(message: "typing...", type: MessageType.Receiver));
                  var mesg = msg.text;
                  msg.text = "";
                  await Future.delayed(const Duration(seconds: 1), () => "1");
                  this.chatMessage.remove(this.chatMessage[this.chatMessage.length - 1]);
                  mesg = (questions.containsKey(mesg))
                      ? questions[mesg]
                      : "not Understand";
                  setState(() {
                    this.chatMessage.add(
                        ChatMessage(message: mesg, type: MessageType.Receiver));

                  });
                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                backgroundColor: Colors.pink,
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
    try {
      this.scrollController.animateTo(this.scrollController.position.maxScrollExtent,duration: const Duration(milliseconds: 500),curve: Curves.easeOut);
    } catch (e) {}
    return scaf;
  }
}

// ignore: must_be_immutable
class ChatBubble extends StatefulWidget {
  ChatMessage chatMessage;
  ChatBubble({@required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type != MessageType.Sender
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type != MessageType.Sender
                ? Colors.white
                : Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text(widget.chatMessage.message),
        ),
      ),
    );
  }
}

class ChatMessage {
  String message;
  MessageType type;
  ChatMessage({@required this.message, @required this.type});
}
