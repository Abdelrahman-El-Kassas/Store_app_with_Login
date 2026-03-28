import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  final Dio dio;

  // الـ Repo هنا هو اللي بيعتمد على Dio
  LoginRepo(this.dio);

  Future<void> loginUser({required String name, required String password}) async {
    try {
      final res = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {"username": name, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (res.statusCode == 200) {
        String usertoken = res.data['accessToken'];
        
        // التخزين في الـ Shared Preferences بقى مسؤولية الـ Repo
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token_key', usertoken);
      } else {
        // لو في إيرور بنرميه عشان الـ Cubit يمسكه
        throw Exception('There is an error with status code: ${res.statusCode}');
      }
    } catch (error) {
      // الـ rethrow بتبعت الإيرور زي ما هو للي نادى على الدالة دي (اللي هو الـ Cubit)
      rethrow; 
    }
  }
}