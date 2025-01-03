import 'dart:convert';

String baseUrl ='https://django-dev.aakscience.com/';

class NetworkEndPoints {
  static String discountBaseUrl = baseUrl;

  ///Login + Register = Auth
  static String signIn = '$baseUrl/user_login/';
  static String signUp = '$baseUrl/signup/';
}
