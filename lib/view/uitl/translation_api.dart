import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class TranslationApi {
 
 

  static Future<String> translate2(
      String message, String fromLanguageCode, String toLanguageCode) async
       {
    final translation = await GoogleTranslator().translate(
      message,
      from: fromLanguageCode,
      to: toLanguageCode,
    );

    return translation.text;
  }
}
