import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/waste_detail_screen.dart';

class ListPosts extends StatefulWidget {

  @override
  State<ListPosts> createState() => _ListPostsState();

}

class _ListPostsState extends State<ListPosts> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      DateTime time = post['date'].toDate();
                      return Semantics(
                          label: 'Food Waste post. Press for detail view',
                          button: true,
                          child: ListTile(
                            trailing: Text(post['quantity'].toString(),
                                style: Theme.of(context).textTheme.headline6),
                            title:  Text(DateFormat.yMMMMEEEEd().format(time),
                                style: Theme.of(context).textTheme.headline6),
                            onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute(
                                  builder: (context) => WasteDetailScreen(post: post)));
                        },
                      ));
                    }
                  )
                ),
              ],
            );
          }
        }
    );
  }

}
