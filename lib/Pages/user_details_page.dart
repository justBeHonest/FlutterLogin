import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Components/components.dart';
import 'package:untitled1/Constants/data_base_constants.dart';
import 'package:untitled1/Constants/string_constants.dart';
import 'package:untitled1/Services/user_service.dart';

class UserDetailsPage extends StatelessWidget {
  Map ui;
  bool isLoading = false;
  final Components _components = Components();
  final UserService _userService = UserService();
  UserDetailsPage({Key? key, required this.ui}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: isLoading
            ? _components.myProgressIndicator()
            : buildStreamBuilder(),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: _userService.getKullanicilar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _components.myProgressIndicator();
          } else {
            List<DocumentSnapshot> list = snapshot.data!.docs;
            for (int i = 0; i < list.length; i++) {
              Map map = list[i].data() as Map;
              return buildListView(context);
            }
          }
          return const Text(
              StringConstants.USER_DETAILS_PAGE_HATA_OLUSTU_MESSAGE);
        });
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: [
        Image.network(ui[DataBaseConstants.DB_PICTURE_URL_FIELD]),
        _components.UserDetailListTileEdit(
          baslik: StringConstants.USER_DETAILS_PAGE_ADI,
          text: ui[DataBaseConstants.DB_NAME_FIELD],
          currentUserInformations: ui,
          editingPlace: DataBaseConstants.DB_NAME_FIELD,
          context: context,
        ),
        _components.UserDetailListTileEdit(
          baslik: StringConstants.USER_DETAILS_PAGE_SOYADI,
          text: ui[DataBaseConstants.DB_LAST_NAME_FIELD],
          currentUserInformations: ui,
          editingPlace: DataBaseConstants.DB_LAST_NAME_FIELD,
          context: context,
        ),
        _components.UserDetailListTile(
          baslik: StringConstants.USER_DETAILS_PAGE_EMAIL,
          text: ui[DataBaseConstants.DB_EMAIL_FIELD],
        ),
        _components.UserDetailListTile(
          baslik: StringConstants.USER_DETAILS_PAGE_PAROLA,
          text: ui[DataBaseConstants.DB_PASSWORD_FIELD],
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(StringConstants.USER_DETAILS_PAGE_APPBAR_TITLE),
    );
  }
}
