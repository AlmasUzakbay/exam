import 'package:flutter/material.dart';
import 'package:flutter_education/generated/locale_keys.g.dart';
import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';
import 'package:flutter_education/presentation/pages/Animation.dart';
import 'package:flutter_education/presentation/pages/GoogleMap.dart';
import 'package:flutter_education/presentation/pages/News.dart';
import 'package:flutter_education/presentation/pages/Qr.dart';

import 'package:flutter_education/presentation/pages/User.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

enum MenuPage { news, UserProfile, MapScreen, animation, qr, logout }

class DrawMenu extends StatefulWidget {
  const DrawMenu({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<DrawMenu> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  MenuPage currentPage = MenuPage.news;

  @override
  Widget build(BuildContext context) {
    String title;
    switch (currentPage) {
      case MenuPage.news:
        title = 'News';
        break;
      case MenuPage.UserProfile:
        title = 'Profile';
        break;
      case MenuPage.MapScreen:
        title = 'Map';
        break;
      case MenuPage.animation:
        title = 'Animation';
        break;
      case MenuPage.qr:
        title = 'Qr';
        break;
      case MenuPage.logout:
        title = 'Log Out';
        break;
    }

    return MaterialApp(
      theme: ThemeData(fontFamily: 'BalsamiqSans'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SliderDrawer(
          appBar: SliderAppBar(
            appBarColor: ColorConst.aftercolor,
            title: Text(title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ),
          key: _sliderDrawerKey,
          sliderOpenSize: 179,
          slider: _SliderView(
            onItemClick: (MenuPage page) {
              _sliderDrawerKey.currentState!.closeSlider();
              setState(() {
                currentPage = page;
              });
            },
          ),
          child: _getPage(currentPage),
        ),
      ),
    );
  }

  Widget _getPage(MenuPage page) {
    switch (page) {
      case MenuPage.news:
        return PostsPage();
      case MenuPage.UserProfile:
        return UserProfilePage();
      case MenuPage.MapScreen:
        return MapScreen();
      case MenuPage.animation:
        return SportsAnimationPage();
      case MenuPage.qr:
        return Qr();
      case MenuPage.logout:
        return Center(child: Text('LogOut Page'));
      default:
        return PostsPage();
    }
  }
}

class _SliderView extends StatelessWidget {
  final Function(MenuPage)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConst.aftercolor,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 30),
          const SizedBox(height: 20),
          const Text(LocaleKeys.Menu,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorConst.primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          const SizedBox(height: 20),
          _SliderMenuItem(
              title: LocaleKeys.news,
              iconData: Icons.home,
              onTap: () => onItemClick?.call(MenuPage.news)),
          _SliderMenuItem(
              title: LocaleKeys.page,
              iconData: Icons.person,
              onTap: () => onItemClick?.call(MenuPage.UserProfile)),
          _SliderMenuItem(
              title: LocaleKeys.story,
              iconData: Icons.photo,
              onTap: () => onItemClick?.call(MenuPage.MapScreen)),
          _SliderMenuItem(
              title: LocaleKeys.Animation,
              iconData: Icons.favorite,
              onTap: () => onItemClick?.call(MenuPage.animation)),
          _SliderMenuItem(
              title: LocaleKeys.Qr_Scanner,
              iconData: Icons.qr_code,
              onTap: () => onItemClick?.call(MenuPage.qr)),
          _SliderMenuItem(
              title: LocaleKeys.LogOut,
              iconData: Icons.arrow_back_ios,
              onTap: () => onItemClick?.call(MenuPage.logout)),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;

  const _SliderMenuItem(
      {Key? key, required this.title, required this.iconData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              color: ColorConst.primarycolor,
              fontFamily: 'BalsamiqSans_Regular')),
      leading: Icon(iconData, color: ColorConst.primarycolor),
      onTap: onTap,
    );
  }
}
