import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePostDTO {
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;
  DateTime? date;

  FoodWastePostDTO(
      {this.imageURL, this.quantity, this.latitude, this.longitude, this.date});

  void addToCloud() {
    FirebaseFirestore.instance
      .collection('posts')
      .add({
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity,
      'imageURL': imageURL,
    });
  }

}
