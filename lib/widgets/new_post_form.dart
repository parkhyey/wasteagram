import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/post_model.dart';

Widget newPostForm(BuildContext context, PostModel newPost){

  return Semantics(
    textField: true,
    focusable: true,
    label: 'New post form',
    child: TextFormField(
      textAlign: TextAlign.center,
      autofocus: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Number of Wasted Items',
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(fontSize: 25.0, height: 2.0),
      onSaved: (value) {
        newPost.quantity = int.tryParse(value!);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of items.';
        }
        return null;
      },
    ),
  );

 }
