import 'package:client/models/detection.dart';
import 'package:client/models/picture.dart';
import 'package:client/models/user.dart';
import 'package:client/view_models/images_viewmodel.dart';
import 'package:dio/dio.dart';
import 'models/detection.dart';

class Api {
  final _dio = Dio(BaseOptions(baseUrl: 'http://192.168.137.1:8081/'));

  Future<List<Detection>> getDetections() async {
    final response = await _dio.get('');
    return (response.data['detections'] as List)
        .map((e) => Detection.fromJson(e))
        .toList();
  }

  Future<List<Picture>> getImages() async {
    final response = await _dio.get('getImages/');
    return (response.data['images'] as List)
        .map((e) => Picture.fromJson(e))
        .toList();
  }

  Future<User> checkUser(String username, String password) async {
    final response =
        await _dio.post('', data: {'username': username, 'password': password});
    return User.fromJson(response.data);
  }

  Future<Picture> getCar(String filename) async {
    final response = await _dio.get('/$filename');
    return Picture.fromJson(response.data['car_image']);
  }

  Future<ImageDetails> getDetialsImages(String filename) async {
    final response = await _dio.get('/getimages/$filename');
    return ImageDetails.fromJson(response.data['images']);
  }
}
