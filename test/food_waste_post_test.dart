import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/waste_post.dart';

void main() {
  final date = DateTime.now();
  const imageURL = 'example_url';
  const quantity = 1;
  const latitude = 1.0;
  const longitude = -2.0;

  final newWastePost = WastePost.fromMap({
    'date' : date,
    'imageURL' : imageURL,
    'quantity' : quantity,
    'latitude' : latitude,
    'longitude' : longitude
  });

  // unit tests to check FoodWastePost model 
  test('Expect new post imageURL matches $imageURL', () {
    expect(newWastePost.imageURL, imageURL);
  });

  test('Expect new post quantity matches $quantity', () {
    expect(newWastePost.quantity, quantity);
  });

  test('Expect new post latitude matches $latitude', () {
    expect(newWastePost.latitude, latitude);
  });

  test('Expect new post longitude matches $longitude', () {
    expect(newWastePost.longitude, longitude);
  });

  test('Expect new post date matches $date', () {
    expect(newWastePost.date, date);
  });

}