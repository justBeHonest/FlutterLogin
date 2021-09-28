import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Components/components.dart';
import 'package:untitled1/Constants/layout_constants.dart';
import 'package:untitled1/Constants/string_constants.dart';
import 'package:untitled1/Models/user_informations.dart';
import 'package:untitled1/Services/user_service.dart';

class UsersPage extends StatelessWidget {
  UserInformations ui;
  UsersPage({required this.ui});
  final UserService _userService = UserService();
  final Components _components = Components();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userService.getKullanicilar(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return _components.myProgressIndicator();
          } else {
            List<DocumentSnapshot> list = snapshot.data.docs;
            return SafeArea(
              child: Scaffold(
                appBar: buildAppBar(),
                body: buildListView(list),
              ),
            );
          }
        });
  }

  ListView buildListView(List<DocumentSnapshot<Object?>> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        Map documentList = list[index].data() as Map;
        return _components.RegisteredUsersListTile(
          context: context,
          kullanicilar: documentList,
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Padding(
        padding: LayoutConstants.USERS_PAGE_RIGHT_PADDING,
        child: Center(
          child: Text(
            StringConstants.USERS_PAGE_APPBAR_TITLE,
          ),
        ),
      ),
    );
  }
}
