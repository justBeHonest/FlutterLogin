import 'package:flutter/material.dart';
import 'package:untitled1/Animations/bouncy_page_route.dart';
import 'package:untitled1/Components/components.dart';
import 'package:untitled1/Constants/string_constants.dart';
import 'package:untitled1/Models/user_informations.dart';
import 'package:untitled1/Pages/users_page.dart';
import 'package:untitled1/Services/user_service.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  UserService _userService = UserService();
  Components _components = Components();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(StringConstants.LOGIN_SCREEN_APPBAR_TEXT),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: height / 6),
          _components.MyLoginScreenTextFormField(
            title: StringConstants.LOGIN_SCREEN_EMAIL_FIELD_TEXT,
            controller: _emailController,
          ),
          _components.MyLoginScreenPasswordTextFormField(
            password: StringConstants.LOGIN_SCREEN_PASSWORD_FIELD_TEXT,
            controller: _passwordController,
          ),
          OutlinedButton(
            onPressed: () {
              signIn(context);
            },
            child: Text(StringConstants.LOGIN_SCREEN_BUTTON_TEXT),
          ),
        ],
      ), //
    );
  }

  void signIn(BuildContext context) async {
    try {
      UserInformations ui = await _userService.signIn(
          _emailController.text.trim(), _passwordController.text.trim());
        Navigator.push(
          context,
          BouncyPageRoute(
            widget: UsersPage(ui: ui),
          ),
        );
    } catch (exception) {
      _components.dialogGoster(context: context, mesaj: StringConstants.LOGIN_SCREEN_EXCPETION + (exception.toString()));
    }
  }
}
