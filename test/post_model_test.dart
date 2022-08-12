import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post_model.dart';

void main() {
  final date = DateTime.now();
  const imageURL = 'example_url';
  const quantity = 1;
  const latitude = 1.0;
  const longitude = -2.0;

  final newPost = PostModel.fromMap({
    'date' : date,
    'imageURL' : imageURL,
    'quantity' : quantity,
    'latitude' : latitude,
    'longitude' : longitude
  });

  // unit tests to check Post model 
  test('Expect new post imageURL matches $imageURL', () {
    expect(newPost.imageURL, imageURL);
  });

  test('Expect new post quantity matches $quantity', () {
    expect(newPost.quantity, quantity);
  });

  test('Expect new post latitude matches $latitude', () {
    expect(newPost.latitude, latitude);
  });

  test('Expect new post longitude matches $longitude', () {
    expect(newPost.longitude, longitude);
  });

  test('Expect new post date matches $date', () {
    expect(newPost.date, date);
  });

  test('Expect post model matches',(){
  PostModel post = PostModel(
    imageURL: 'test_post.com',
    quantity: 5,  
    latitude: 100,
    longitude: 50
    );
    
    expect(post.imageURL, 'test_post.com');
    expect(post.quantity, 5);
    expect(post.latitude, 100);
    expect(post.longitude, 50);
  });

}