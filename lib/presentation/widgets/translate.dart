import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Eazy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageButton(context, Locale('en'), 'English'),
          _buildLanguageButton(context, Locale('ru'), 'Русский'),
          _buildLanguageButton(context, Locale('kk'), 'Қазақша'),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(
      BuildContext context, Locale locale, String languageName) {
    return ListTile(
      title: Text(languageName),
      onTap: () {
        context.setLocale(locale);
        Navigator.pop(context);
      },
    );
  }
}