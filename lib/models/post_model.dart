class PostModel {
  DateTime? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  PostModel(
    {this.date, this.imageURL, this.quantity, this.latitude, this.longitude}
  );

  PostModel.fromMap(Map map) {
    date = map['date'];
    imageURL = map['imageURL'];
    quantity = map['quantity'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

}