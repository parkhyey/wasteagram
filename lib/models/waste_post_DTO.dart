import 'package:cloud_firestore/cloud_firestore.dart';

class WastePostDTO {
  DateTime? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  WastePostDTO(
      {this.imageURL, this.quantity, this.latitude, this.longitude, this.date});

  void addToCloud() {
    FirebaseFirestore.instance.collection('posts').add({
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });
  }

}
