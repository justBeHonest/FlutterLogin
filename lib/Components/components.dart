import 'package:flutter/material.dart';
import 'package:untitled1/Animations/bouncy_page_route.dart';
import 'package:untitled1/Constants/color_constants.dart';
import 'package:untitled1/Constants/data_base_constants.dart';
import 'package:untitled1/Constants/layout_constants.dart';
import 'package:untitled1/Constants/string_constants.dart';
import 'package:untitled1/Pages/user_details_page.dart';
import 'package:untitled1/Services/user_service.dart';

class Components {
  UserService userService = UserService();

  Widget MyLoginScreenTextFormField(
      {required String title, required TextEditingController controller}) {
    return Padding(
      padding: LayoutConstants.EIGHT_PADDING,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          fillColor: ColorConstants.WHITE,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }

  Widget MyLoginScreenPasswordTextFormField(
      {required String password, required TextEditingController controller}) {
    return Padding(
      padding: LayoutConstants.EIGHT_PADDING,
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: password,
          fillColor: ColorConstants.WHITE,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }

  void dialogGoster({required BuildContext context, required String mesaj}) {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 24,
        title: Text(
          mesaj,
          style: const TextStyle(
            color: ColorConstants.BLUE,
          ),
        ),
      ),
    );
  }

  Widget myProgressIndicator() {
    return Center(
      child: Container(
        width: LayoutConstants.CIRCULAR_PROGRESS_SIZE,
        height: LayoutConstants.CIRCULAR_PROGRESS_SIZE,
        child: CircularProgressIndicator(
          backgroundColor: ColorConstants.INDICATOR_COLOR,
          strokeWidth: LayoutConstants.CIRCULAR_PROGRESS_THICKNESS,
        ),
      ),
    );
  }

  Widget RegisteredUsersListTile({
    required Map kullanicilar,
    required BuildContext context,
  }) {
    var size = MediaQuery.of(context).size;
    String adSoyad = kullanicilar[DataBaseConstants.DB_NAME_FIELD] +
        ' ' +
        kullanicilar[DataBaseConstants.DB_LAST_NAME_FIELD];
    return Padding(
      padding: const EdgeInsets.only(
        top: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        right: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        left: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
      ),
      child: ListTile(
        shape: roundedRectangleBorder(),
        onTap: () {
          UserDetailsPageRoute(context, kullanicilar);
        },
        leading:
            Image.network(kullanicilar[DataBaseConstants.DB_PICTURE_URL_FIELD]),
        title: Text(
          adSoyad,
          style: textStyle(size),
        ),
      ),
    );
  }

  TextStyle textStyle(Size size) {
    return TextStyle(
      color: ColorConstants.TEXT_COLOR,
      fontSize: size.width * 0.045,
      fontWeight: FontWeight.bold,
    );
  }

  void UserDetailsPageRoute(
      BuildContext context, Map<dynamic, dynamic> kullanicilar) {
    Navigator.push(
      context,
      BouncyPageRoute(
        widget: UserDetailsPage(
          ui: kullanicilar,
        ),
      ),
    );
  }

  RoundedRectangleBorder roundedRectangleBorder() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(
        color: ColorConstants.BLUE,
        width: 4.0,
      ),
    );
  }

  Widget UserDetailListTile({
    required String baslik,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        right: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        top: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
      ),
      child: ListTile(
        title: Text(baslik),
        shape: roundedRectangleBorder(),
        subtitle: Text(text),
      ),
    );
  }

  Widget UserDetailListTileEdit({
    required String baslik,
    required String text,
    required Map currentUserInformations,
    required String editingPlace,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        right: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        top: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
      ),
      child: ListTile(
        title: Text(baslik),
        shape: roundedRectangleBorder(),
        subtitle: Text(text),
        trailing: OutlinedButton(
          child: const Text(StringConstants.CREATE_DIALOG_DUZENLE),
          onPressed: () {
            if (editingPlace == DataBaseConstants.DB_NAME_FIELD) {
              // İsmini Güncelleyecekse
              createAlertDialogForNameEditing(currentUserInformations, context);
            } else if (editingPlace == DataBaseConstants.DB_LAST_NAME_FIELD) {
              // Soyismini Günceliyecekse
              createAlertDialogForLastNameEditing(
                  currentUserInformations, context);
            }
          },
        ),
      ),
    );
  }

  createAlertDialogForNameEditing(Map ui, BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = ui[DataBaseConstants.DB_NAME_FIELD];
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            StringConstants.USER_DETAILS_PAGE_EDIT_NAME_DIALOG_MESSAGE,
            style: TextStyle(
              color: ColorConstants.TEXT_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: StringConstants.CREATE_DIALOG_ISIM,
            ),
          ),
          actions: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFFFFE4E1);
                    }
                    return const Color(
                        0xFFFA9D93); // Use the component's default.
                  },
                ),
              ),
              child: const Text(
                StringConstants.CREATE_DIALOG_IPTAL,
                style: TextStyle(color: ColorConstants.WHITE),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const Text(StringConstants.CREATE_DIALOG_GUNCELLE),
              onPressed: () {
                userService.updateName(
                    newData: controller.text, currentUserInfo: ui);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  createAlertDialogForLastNameEditing(Map ui, BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = ui[DataBaseConstants.DB_LAST_NAME_FIELD];
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            StringConstants.USER_DETAILS_PAGE_EDIT_LAST_NAME_DIALOG_MESSAGE,
            style: TextStyle(
              color: ColorConstants.TEXT_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: inputDecoration(),
          ),
          actions: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFFFFE4E1);
                    }
                    return const Color(
                        0xFFFA9D93); // Use the component's default.
                  },
                ),
              ),
              child: const Text(
                StringConstants.CREATE_DIALOG_IPTAL,
                style: TextStyle(color: ColorConstants.WHITE),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const Text(StringConstants.CREATE_DIALOG_GUNCELLE),
              onPressed: () {
                userService.updateLastName(
                    newData: controller.text, currentUserInfo: ui);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  InputDecoration inputDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      labelText: StringConstants.CREATE_DIALOG_SOY_ISIM,
    );
  }
}
