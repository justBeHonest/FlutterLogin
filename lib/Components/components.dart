import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Animations/bouncy_page_route.dart';
import 'package:untitled1/Constants/color_constants.dart';
import 'package:untitled1/Constants/data_base_constants.dart';
import 'package:untitled1/Constants/layout_constants.dart';
import 'package:untitled1/Constants/string_constants.dart';
import 'package:untitled1/Models/user_informations.dart';
import 'package:untitled1/Pages/user_details_page.dart';
import 'package:untitled1/Services/user_service.dart';

class Components {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserService userService = UserService();

  Widget MyLoginScreenTextFormField(
      {required String title, required TextEditingController controller}) {
    return Padding(
      padding: LayoutConstants.EIGHT_PADDING,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          fillColor: ColorConstants.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
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
          fillColor: ColorConstants.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
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
          style: TextStyle(
            color: Colors.blue,
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
          backgroundColor: Colors.grey[300],
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.blue,
            width: 4.0,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            BouncyPageRoute(
              widget: UserDetailsPage(
                ui: kullanicilar,
              ),
            ),
          );
        },
        leading:
            Image.network(kullanicilar[DataBaseConstants.DB_PICTURE_URL_FIELD]),
        title: Text(
          adSoyad,
          style: TextStyle(
            color: Colors.blue[700],
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.blue,
            width: 4.0,
          ),
        ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.blue,
            width: 4.0,
          ),
        ),
        subtitle: Text(text),
        trailing: OutlinedButton(
          child: Text('Düzenle'),
          onPressed: () {
            if(editingPlace == DataBaseConstants.DB_NAME_FIELD){ // İsmini Güncelleyecekse
              createAlertDialogForNameEditing(currentUserInformations, context);
            } else if(editingPlace == DataBaseConstants.DB_LAST_NAME_FIELD){ // Soyismini Günceliyecekse
              createAlertDialogForLastNameEditing(currentUserInformations, context);
            }
          },
        ),
      ),
    );
  }
/*
  Widget KullaniciDetaylariEditListTile({
    required BuildContext context,
    required String baslik,
    required String text,
    required String index,
    required UserInformations ui,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        right: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
        top: LayoutConstants.USERS_PAGE_LIST_TILE_PADDING,
      ),
      child: ListTile(
        trailing: InkWell(
          onTap: () {
            if (index == 'adres') {
              createAlertDialog(ui, context);
            } else if (index == 'firmaAd') {
              createAlertDialog2(ui, context);
            }
          },
          child: Column(
            children: [
              Expanded(child: SizedBox()),
              Expanded(child: Text('Düzenle')),
              Expanded(child: Icon(Icons.edit)),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
        title: Text(baslik),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.blue,
            width: 4.0,
          ),
        ),
        subtitle: Text(text),
      ),
    );
  }
*//*
  createAlertDialog2(UserInformations ui, BuildContext context) {
    TextEditingController controller2 = TextEditingController();
    controller2.text = ui.firmaAd;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Firma İsminizi düzenleyin\n\n(Çekin elinize ulaşması için firma adınızın mutlaka doğru girmelisiniz!)',
            style: TextStyle(
              color: Colors.blue[700],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            autofocus: true,
            controller: controller2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Firma İsmi',
            ),
          ),
          actions: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xFFFFE4E1);
                    return Color(0xFFFA9D93); // Use the component's default.
                  },
                ),
              ),
              child: Text(
                'İptal',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: Text('Güncelle'),
              onPressed: () {
                veriTabaniAdresGuncelle2(ui, controller2.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
*/

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
              color: Colors.blue[700],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'İsim',
            ),
          ),
          actions: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xFFFFE4E1);
                    return Color(0xFFFA9D93); // Use the component's default.
                  },
                ),
              ),
              child: Text(
                'İptal',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: Text('Güncelle'),
              onPressed: () {
                userService.updateName(newData: controller.text, currentUserInfo: ui);
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
              color: Colors.blue[700],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Soyisim',
            ),
          ),
          actions: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xFFFFE4E1);
                    return Color(0xFFFA9D93); // Use the component's default.
                  },
                ),
              ),
              child: Text(
                'İptal',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: Text('Güncelle'),
              onPressed: () {
                userService.updateLastName(newData: controller.text, currentUserInfo: ui);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



/*
  veriTabaniAdresGuncelle(UserInformations ui, String adres) async {
    CollectionReference kullaniciRef = _firestore.collection('Kullanıcılar');
    var kullaniciResponse = await kullaniciRef.get();
    var kullaniciList = kullaniciResponse.docs;
    for (int i = 0; i < kullaniciList.length; i++) {
      dynamic mapKullanici = kullaniciList[i];
      if (ui.email == mapKullanici['email']) {
        ui.adres = adres;
        await kullaniciRef.doc(kullaniciList[i].id).update({'adres': adres});
      }
    }
  }

  veriTabaniAdresGuncelle2(UserInformations ui, String firmaAd) async {
    CollectionReference kullaniciRef = _firestore.collection('Kullanıcılar');
    var kullaniciResponse = await kullaniciRef.get();
    var kullaniciList = kullaniciResponse.docs;
    for (int i = 0; i < kullaniciList.length; i++) {
      dynamic mapKullanici = kullaniciList[i];
      if (ui.email == mapKullanici['email']) {
        ui.firmaAd = firmaAd;
        await kullaniciRef
            .doc(kullaniciList[i].id)
            .update({'firmaAd': firmaAd});
      }
    }
  }
*/
}
