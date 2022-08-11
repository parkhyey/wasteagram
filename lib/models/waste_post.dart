class WastePost {
  DateTime? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  WastePost(
    {this.date, this.imageURL, this.quantity, 
    this.latitude, this.longitude}
  );

  WastePost.fromMap(Map map) {
    date = map['date'];
    imageURL = map['imageURL'];
    quantity = map['quantity'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

}