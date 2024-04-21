// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "login": "Login",
    "register": "Registration",
    "fullName": "Full Name",
    "city": "City",
    "phoneNumber": "Phone Number",
    "user": "User Profile",
    "story": "Story",
    "email": "Email",
    "password": "Password",
    "qr": "Enter Data fot Qr",
    "qrgen": "Generate QR Code",
    "qrdone": "Your Qr Code",
    "close": "Close",
    "page": "User Page",
    "Stories": "Stories",
    "Animation": "Animation",
    "Qr_Scanner": "Qr Scanner",
    "LogOut": "LogOut",
    "Menu": "Menu",
    "news": "News",
  };
  static const Map<String, dynamic> kk = {
    "login": "Kіру",
    "register": "Тіркелу",
    "fullName": "Толық Аты Жөні",
    "city": "Қала",
    "phoneNumber": "Телефон Нөмірі",
    "user": "Пайдаланушы Профилі",
    "story": "Сторис",
    "email": "Пошта",
    "password": "Пароль",
    "qr": "QR Деректерін енгізіңіз",
    "qrgen": "Qr Code Жасау",
    "qrdone": "Сіздің Qr Code",
    "close": "Жабу",
    "page": "Қолданушының Парақшасы",
    "Stories": "Сторис",
    "Animation": "Анимация",
    "Qr_Scanner": "Qr Сканер",
    "LogOut": "Шығу",
    "Menu": "Меню",
    "news": "Жаңалықтар",
  };
  static const Map<String, dynamic> ru = {
    "login": "Вход",
    "register": "Регистрация",
    "fullName": "Полное Имя",
    "city": "Город",
    "phoneNumber": "Номер телефона",
    "user": "Профиль Пользователя",
    "story": "Сторис",
    "email": "Почта",
    "password": "Пароль",
    "qr": "Введите данные для QR",
    "qrgen": "Сгенерировать Qr Code",
    "qrdone": "Ваш Qr Code",
    "close": "Закрыть",
    "page": "Страница Пользователя",
    "Stories": "Сторис",
    "Animation": "Анимация",
    "Qr_Scanner": "Qr Сканер",
    "LogOut": "Выйти",
    "Menu": "Меню",
    "news": "Новости",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "kk": kk,
    "ru": ru
  };
}
