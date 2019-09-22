import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
var id_counter = 0;

class ChatScreen extends StatefulWidget {
 
  @override
  State<StatefulWidget> createState() {
    return Chatting();
  }
}

class Chatting extends State<ChatScreen> {
  String textFieldValue;
  TextEditingController controlText = TextEditingController();

  bool istyping = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // Future printForMe() async{
  //   if (istyping){
  //     await 
  //   }
  //   else
  //     print('not Typing');
  // }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        title: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Image.asset(
//              'assets/images/earth.png',
//              fit: BoxFit.contain,
//              height: 32,
//            ),
//            Container(
//              padding: const EdgeInsets.all(8.0), child: Text('World Chat'),
//            )
//          ],
//
//        ),
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MessageStream(),
            //istyping ? Text('Ahmed is typing') : Text('not Typing'),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      controller: controlText,
                      autofocus: true,
                      onChanged: (value) {
                        if(controlText.value == null) {
                          istyping = false;
                        }
                        else {
                          if(controlText.value != null)
                        {
                           istyping = true;
                           Text('Ahmed is typing');
                        }
                        print(istyping);
                        }
                        textFieldValue = value;
                      },
                     onSubmitted: (value){
                       istyping = false;
                     },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.purple[600],
                      onPressed: () {
                        setState(() {
                          if (controlText.text.isNotEmpty) {
                            controlText.clear();
                            _firestore.collection('rasael').add({
                              'text': textFieldValue,
                              'sender': loggedInUser.email,
                              'id': ++id_counter
                            });
                          }
                          istyping = false;
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Message Stream with StreamBuilder..
class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('rasael')
            .orderBy('id', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('nothing to show...'),
            );
          }
          var messages = snapshot.data.documents.reversed;

          List<MessageBubble> messagesWidget = [];
          for (var message in messages) {
            print("hi ${message.data['text']}");
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            var messageId = message.data['id'];
            final currentUser = loggedInUser.email;
            final bool ismCurrentUser = currentUser == messageSender;
            final messageWidget = MessageBubble(
              text: messageText,
              sender: messageSender,
              isCurrentUser: ismCurrentUser,
              id: messageId,
            );
            if (id_counter < messageId) id_counter = messageId;
            messagesWidget.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messagesWidget,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isCurrentUser, this.id});

  final id;
  final String text, sender;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
              color: isCurrentUser ? Colors.purple[600] : Colors.white70,
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.elliptical(20, 40)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //10 20 is better
                child: Text(
                  text,
                  style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black54,
                      fontSize: 20.0),
                ),
              )),
        ],
      ),
    );
  }
}
