import 'package:flutter/material.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

import 'package:shortnews/view/uitl/translation_api.dart';
import 'package:shortnews/view/uitl/translations.dart';

class TranslationWidget extends StatefulWidget 
{
  final String message;

  final Widget Function(String translation) builder;

  const TranslationWidget({
    required this.message,
   
    required this.builder,
     Key? key,
  }) : super(key: key);

  @override
  _TranslationWidgetState createState() => _TranslationWidgetState();
}

class _TranslationWidgetState extends State<TranslationWidget> {
  String? translation;

  @override
  Widget build(BuildContext context) 
  {
      final fromLanguageCode = sharedPref.getString(AppStringFile.fromLanguageCode).toString();
     final toLanguageCode = sharedPref.getString(AppStringFile.toLanguageCode).toString();
    //final fromLanguageCode = Translations.getLanguageCode(widget.fromLanguage);
    //final toLanguageCode = Translations.getLanguageCode(widget.toLanguage);

    return FutureBuilder(
      //future: TranslationApi.translate(widget.message, toLanguageCode),
      future: TranslationApi.translate2(
          widget.message, fromLanguageCode, toLanguageCode),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return buildWaiting();
          default:
            if (snapshot.hasError) {
              translation = 'Could not translate due to Network problems';
            } else {
              translation = snapshot.data;
            }
            return widget.builder(translation!);
        }
      },
    );
  }

  Widget buildWaiting() =>
      translation == null ? Container() : widget.builder(translation!);
}
