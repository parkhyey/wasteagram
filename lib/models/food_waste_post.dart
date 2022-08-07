class FoodWastePost {
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;
  DateTime? date;

  FoodWastePost(
      {this.imageURL, this.quantity, this.latitude, this.longitude, this.date});

  FoodWastePost.fromMap(Map map) {
    date = map['date'];
    imageURL = map['imageURL'];
    quantity = map['quantity'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

}