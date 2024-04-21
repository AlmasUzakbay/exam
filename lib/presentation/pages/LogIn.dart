import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/generated/locale_keys.g.dart';
import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';
import 'package:flutter_education/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_education/presentation/bloc/auth/auth_event.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.login,
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: ColorConst.endcolor,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.email,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: ColorConst.primarycolor),
                    ),
                    prefixIcon:
                        Icon(Icons.email, color: ColorConst.primarycolor),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.password,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: ColorConst.primarycolor),
                    ),
                    prefixIcon:
                        Icon(Icons.lock, color: ColorConst.primarycolor),
                    suffixIcon: Icon(Icons.visibility_off,
                        color: ColorConst.primarycolor),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _login(context),
                  child: Text(LocaleKeys.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.thirdcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text(LocaleKeys.register,
                      style: TextStyle(color: ColorConst.primarycolor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      SignInRequested(_emailController.text, _passwordController.text),
    );
    Navigator.pushNamed(context, '/drawmenu');
  }
}
