import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../model/notes.dart';
import '../model/posts.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<List<Posts>> fetchPosts() async {
    try {
      final response = await _dio.get('/all-circular');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Posts.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  Future<Posts?> fetchDataBySlug(String slug, String id) async {
    try {

      final response = await _dio.get("/$id/$slug");

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        if (response.data is Map<String, dynamic>) {
          if (kDebugMode) {
            print(response.data);
          }
          return Posts.fromJson(response.data);
        } else {
          throw Exception('Invalid response format: ${response.data.runtimeType}');
        }
      } else {
        throw Exception('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching posts: $e');
      return null;
    }
  }


  Future<List<Notes>> fetchNotes() async {

    try {
      final response = await _dio.get('/all/notes');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (kDebugMode) {
          print(response.data);
        }
        return data.map((json) => Notes.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      throw Exception('Error fetching notes: $e');
    }
  }


  Future<Response?> register(String name, String email, String password, String passwordConfirmation) async {
    try {
      final response = await _dio.post('/register', data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation
      });

      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
      if (e.response != null) {
        return e.response;
      } else {
        throw Exception("No Internet Connection");
      }
    }
  }

  Future<Response?> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        "email": email,
        "password": password,
      });

      return response;
    } on DioException catch (e) {
      print(e.response);
      print(e.message);
      print(e.error);
      if (e.response != null) {
        return e.response;
      } else {
        throw Exception("No Internet Connection");
      }
    }
  }


  final box = GetStorage();

  Future<Response?> logout() async {
    String? token = box.read("token");

    if (token == null) {
      return null;
    }

    try {
      final response = await _dio.post('/logout',
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response;
      } else {
        throw Exception("No Internet Connection");
      }
    }
  }

  Future<Response?> forgetPassword(String email) async {
    try {
      Response response = await _dio.post('/password/email', data: {'email': email});
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response;
      }else{
        throw Exception("No Internet Connection");
      }
    }
  }

  Future<Response?> resetPassword(String email, String password, String confirmPassword, String token) async {
    try {
      Response response = await _dio.post('/password/reset', data: {
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "token": token,
      });

      return response;

    } on DioException catch (e) {
      if (e.response != null) {
        return e.response;
      } else {
        throw Exception("No Internet Connection");
      }
    }
  }

  Future<Notes?> fetchNoteBySlug(String slug, String id) async {
    try {

      final response = await _dio.get("/note/$id/$slug");

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        if (response.data is Map<String, dynamic>) {
          if (kDebugMode) {
            print(response.data);
          }
          return Notes.fromJson(response.data);
        } else {
          throw Exception('Invalid response format: ${response.data.runtimeType}');
        }
      } else {
        throw Exception('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching note: $e');
      return null;
    }
  }
}
