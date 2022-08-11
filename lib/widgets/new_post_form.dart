import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/waste_post_DTO.dart';

Widget newPostForm(BuildContext context, WastePostDTO newPost){

  return Semantics(
    textField: true,
    focusable: true,
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
