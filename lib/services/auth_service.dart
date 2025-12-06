import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'secure_storage_service.dart';

class OtpService{
  final String baseUrl = 'https://api.yourdomain.com'; // تغییر به آدرس عمومی

  Future<String> sendOtp(String PhoneNumber) async {
    final url = Uri.parse(baseUrl + '/api/Auth/create-otp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'phone': PhoneNumber}),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        print("Success: OTP requested.");
        final hashcode = jsonResponse['data'];
        return hashcode;

      } else {
        print("Error: ${response.statusCode}");
        String serverMessage = 'خطا در ارسال OTP.';
        try {
          final errorJson = json.decode(utf8.decode(response.bodyBytes));
          serverMessage = errorJson['message'] ?? 'خطای سرور نامشخص (${response.statusCode}).';
        } catch (_) {
          serverMessage = 'خطای سرور: کد ${response.statusCode}.';
        }
        throw Exception(serverMessage);
      }
    } on TimeoutException {
      throw Exception('اتصال به سرور قطع شد. لطفا اتصال اینترنت خود را بررسی کنید.');
    } catch (e) {
      throw Exception('خطای شبکه: ${e.toString()}');
    }
  }


}


