import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  final date = DateTime.now();
  const imageURL = 'example_url';
  const quantity = 1;
  const latitude = 1.0;
  const longitude = -2.0;

  final newWastePost = FoodWastePost.fromMap({
    'date' : date,
    'imageURL' : imageURL,
    'quantity' : quantity,
    'latitude' : latitude,
    'longitude' : longitude
  });

  //Unit tests to check model variable assignments
  test('Expect new post imageURL matches', () {
    expect(newWastePost.imageURL, imageURL);
  });

  test('Expect new post quantity matches', () {
    expect(newWastePost.quantity, quantity);
  });

  test('Expect new post latitude matches', () {
    expect(newWastePost.latitude, latitude);
  });

  test('Expect new post longitude matches', () {
    expect(newWastePost.longitude, longitude);
  });

  test('Expect new post date equals $date', () {
    expect(newWastePost.date, date);
  });

}