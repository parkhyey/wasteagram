import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WasteDetailScreen extends StatelessWidget {
  
  DocumentSnapshot post;
  WasteDetailScreen({Key? key, required this.post}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    DateTime time = post['date'].toDate();
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: const Text('Wasteagram')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(DateFormat.yMMMEd().format(time),
              style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 200, child: Image.network(post['imageURL'].toString())),
            Text('${post['quantity'].toString()} items',
              style: Theme.of(context).textTheme.headline5),
            Text('Location: (${post['latitude'].toString()}, '
              '${post['longitude'].toString()})')
          ],
        ),
      ),
      
    );
  }

}