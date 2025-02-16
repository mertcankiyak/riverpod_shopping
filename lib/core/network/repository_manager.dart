import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/base_model.dart';
import '../model/error_model.dart';

class RepositoryManager {
  Dio? dio;
  RepositoryManager({this.dio});

  Future fetch<T extends BaseModel>(
      {required String path,
      required T model,
      Map<String, dynamic>? queryParameters,
      Iterable<MapEntry<String, dynamic>>? headers}) async {
    try {
      dio?.options.headers.addEntries(headers ?? []);
      var response = await dio?.get(path, queryParameters: queryParameters);
      if (response?.data is Map) {
        var data = model.fromJson(json.decode(json.encode(response?.data)));
        return data;
      } else if (response?.data is List) {
        return List<T>.from(json
            .decode(json.encode(response?.data))
            .map((x) => model.fromJson(x)));
      } else if (response?.data is String) {
        var data = bool.parse(response?.data);
        return data;
      } else {
        return response?.statusCode;
      }
    } on DioException catch (error, stacktrace) {
      if (error.response?.statusCode != 200) {
        model.error = ErrorModel(errorMessage: error.message);
        return model;
      }
    }
  }

  Future post<T extends BaseModel>(
      {required String path,
      required T model,
      Object? data,
      Map<String, dynamic>? queryParameters,
      Iterable<MapEntry<String, dynamic>>? headers}) async {
    Response? response;
    try {
      response =
          await dio?.post(path, data: data, queryParameters: queryParameters);
      if (response?.data is Map) {
        var data = model.fromJson(json.decode(json.encode(response?.data)));
        return data;
      } else if (response?.data is List) {
        return List<T>.from(json
            .decode(json.encode(response?.data))
            .map((x) => model.fromJson(x)));
      }
    } on DioException catch (error, stacktrace) {
      if (error.response?.statusCode == 400) {
        model.error =
            ErrorModel.fromJson(json.decode(json.encode(error.response?.data)));
        return model;
      }
    }
  }
}
