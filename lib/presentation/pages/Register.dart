import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/generated/locale_keys.g.dart';
import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';
import 'package:flutter_education/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_education/presentation/bloc/auth/auth_event.dart';
import 'package:flutter_education/presentation/widgets/translate.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.register,
            style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Eazy(),
              );
            },
          ),
        ],
        backgroundColor: ColorConst.primarycolor,
      ),
      body: Container(
        color: ColorConst.endcolor,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTextField(
                    _fullNameController, LocaleKeys.fullName, Icons.person),
                _buildTextField(
                    _cityController, LocaleKeys.city, Icons.location_city),
                _buildTextField(_phoneNumberController, LocaleKeys.phoneNumber,
                    Icons.phone),
                _buildTextField(
                    _emailController, LocaleKeys.email, Icons.email),
                _buildTextField(
                    _passwordController, LocaleKeys.password, Icons.lock,
                    isPassword: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _register(context),
                  child: Text(LocaleKeys.register),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.thirdcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: ColorConst.primarycolor),
          ),
          prefixIcon: Icon(icon, color: ColorConst.primarycolor),
          suffixIcon: isPassword
              ? Icon(Icons.visibility_off, color: ColorConst.primarycolor)
              : null,
        ),
        obscureText: isPassword,
      ),
    );
  }

  void _register(BuildContext context) async {
    BlocProvider.of<AuthenticationBloc>(context).add(
      SignUpRequested(_emailController.text, _passwordController.text),
    );

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullName': _fullNameController.text,
        'city': _cityController.text,
        'phoneNumber': _phoneNumberController.text,
        'email': _emailController.text,
      });
      Navigator.pushNamed(context, '/drawmenu');
    }
  }
}
