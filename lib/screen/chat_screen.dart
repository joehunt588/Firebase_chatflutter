import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/chats/edUfU2RHIfyAZThpGlnm/messages/')
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: streamSnapshot.data.docs.length,
            itemBuilder: (context, i) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/edUfU2RHIfyAZThpGlnm/messages/')
              .add({'text': 'button'});
        },
      ),
    );
  }
}
