import 'package:dio/dio.dart';

class NetworkHelper {
  var dio = Dio();
  Response response;
  FormData formData;
  final String url = "https://4b41b292d024.ngrok.io";

  Future<String> predictCrop(Map<String, String> formBody) async {
    try {
      formData = new FormData.fromMap(formBody);
      response = await dio.post(
        url + "/predict1",
        data: formData,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.data['predictedCrop'];
      } else {
        print(response.statusCode);
        return "Couldn't predict the crop.";
      }
    } catch (err) {
      print(err);
      return "Couldn't predict the crop.";
    }
  }

  Future<Map> identifyDisease(String encodedImage) async {
    try {
      response = await dio.post(
        url + "/predict",
        data: {'image': encodedImage},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.data['prediction'];
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
