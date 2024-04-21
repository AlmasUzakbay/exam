import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_education/generated/locale_keys.g.dart';
import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfilePage> {
  String userUid = FirebaseAuth.instance.currentUser?.uid ?? '';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadAvatarUrl();
  }

  Future<void> _loadAvatarUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarUrl = prefs.getString('avatarUrl');
    });
  }

  Future<void> _updateAvatarUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarUrl', url);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _updateAvatarUrl(pickedFile.path);
      setState(() {
        _avatarUrl = pickedFile.path;
      });
    }
  }

  ImageProvider<Object> _getAvatarImage() {
    if (_avatarUrl == null) {
      return const AssetImage('assets/images/default_avatar.jpg');
    }
    if (kIsWeb) {
      return NetworkImage(_avatarUrl!);
    } else {
      return FileImage(File(_avatarUrl!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userUid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildErrorScreen(snapshot.error.toString());
          }
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return _buildErrorScreen("User data unavailable.");
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return _buildProfileScreen(userData);
        }
        return _buildLoadingScreen();
      },
    );
  }

  Scaffold _buildProfileScreen(Map<String, dynamic> userData) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildAvatar(),
                SizedBox(height: 20),
                _buildUserInfoCard(userData),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 80,
        backgroundImage: _getAvatarImage(),
        backgroundColor: ColorConst.firstcolor,
        child: _avatarUrl == null
            ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
            : null,
      ),
    );
  }

  Card _buildUserInfoCard(Map<String, dynamic> userData) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _userInfo(LocaleKeys.fullName, userData['fullName']),
            Divider(),
            _userInfo(LocaleKeys.city, userData['city']),
            Divider(),
            _userInfo(LocaleKeys.phoneNumber, userData['phoneNumber']),
          ],
        ),
      ),
    );
  }

  Widget _userInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: ColorConst.primarycolor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value ?? 'Not available',
            style: TextStyle(
              fontSize: 16,
              color: ColorConst.primarycolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _buildErrorScreen(String errorMessage) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.user)),
      body: Center(
        child: Text(
          errorMessage,
          style: TextStyle(
            color: ColorConst.secondcolor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Scaffold _buildLoadingScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.user)),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
