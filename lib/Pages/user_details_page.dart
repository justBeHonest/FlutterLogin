import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Components/components.dart';
import 'package:untitled1/Constants/data_base_constants.dart';
import 'package:untitled1/Constants/layout_constants.dart';
import 'package:untitled1/Constants/string_constants.dart';
import 'package:untitled1/Services/user_service.dart';

class UserDetailsPage extends StatelessWidget {
  Map ui;
  bool isLoading = false;
  Components _components = Components();
  UserService _userService = UserService();
  UserDetailsPage({required this.ui});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConstants.USER_DETAILS_PAGE_APPBAR_TITLE),
        ),
        body: isLoading
            ? _components.myProgressIndicator()
            : StreamBuilder<QuerySnapshot>(
                stream: _userService.getKullanicilar(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return _components.myProgressIndicator();
                  } else {
                    List<DocumentSnapshot> list = snapshot.data!.docs;
                    for (int i = 0; i < list.length; i++) {
                      Map map = list[i].data() as Map;
                      return ListView(
                        children: [
                          Image.network(
                              ui[DataBaseConstants.DB_PICTURE_URL_FIELD]),
                          _components.UserDetailListTileEdit(
                            baslik: 'ADI',
                            text: ui[DataBaseConstants.DB_NAME_FIELD],
                            currentUserInformations: ui,
                            editingPlace: DataBaseConstants.DB_NAME_FIELD,
                            context: context,
                          ),
                          _components.UserDetailListTileEdit(
                            baslik: 'SOYADI',
                            text: ui[DataBaseConstants.DB_LAST_NAME_FIELD],
                            currentUserInformations: ui,
                            editingPlace: DataBaseConstants.DB_LAST_NAME_FIELD,
                            context: context,
                          ),
                          _components.UserDetailListTile(
                            baslik: 'EMAIL',
                            text: ui[DataBaseConstants.DB_EMAIL_FIELD],
                          ),
                          _components.UserDetailListTile(
                            baslik: 'PAROLA',
                            text: ui[DataBaseConstants.DB_PASSWORD_FIELD],
                          ),
                          SizedBox(height: 50),
                        ],
                      );
                      /*

                      if (ui[DataBaseConstants.DB_EMAIL_FIELD] ==
                          map['email']) {
                        return ListView(
                          children: [
                            _components.UserDetailListTile(
                              baslik: 'ADI',
                              text: map['ad'],
                            ),
                            _components.UserDetailListTile(
                              baslik: 'SOYADI',
                              text: map['soyad'],
                            ),
                            _components.UserDetailListTile(
                              baslik: 'ADRESİ',
                              text: map['adres'],
                              index: 'adres',
                              ui: widget.ui,
                              context: context,
                            ),
                            _components.UserDetailListTile(
                              baslik: 'EMAİLİ',
                              text: map['email'],
                            ),
                            _components.UserDetailListTile(
                              baslik: 'FİRMA İSMİ ',
                              text: map['firmaAd'],
                              index: 'firmaAd',
                              ui: widget.ui,
                              context: context,
                            ),
                            _components.UserDetailListTile(
                              baslik: 'PUANI',
                              text: map['puan'].toString(),
                            ),
                            _components.UserDetailListTile(
                              baslik: 'TELEFON NUMARASI',
                              text: map['tel'],
                            ),
                            Padding(
                              padding: LayoutConstants.paddingEightPixel(),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.red[100],
                                  side: BorderSide(
                                      width: 1.0, color: ColorConstants.RED),
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(
                                        'HESABI SİLMEK İSTEDİĞİNİZE EMİN MİSİNİZ? BU İŞLEM GERİ ALINAMAZ!!(MEVCUT PUANLARINIZ VARSA SİLİNECEK!!)',
                                        style: TextStyle(
                                          color: ColorConstants.RED,
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.of(mainContext).pop();
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await _authService
                                                .deleteCurrentUser(
                                                    ui: widget.ui,
                                                    context: mainContext);
                                            Navigator.of(mainContext).pop();
                                            Navigator.of(mainContext).pop();
                                            _components.dialogGoster(
                                              context: mainContext,
                                              mesaj: 'HESABINIZ SİLİNDİ.',
                                            );
                                          },
                                          child: Text('EVET',
                                              style: TextStyle(
                                                  color: ColorConstants.WHITE)),
                                          style: ElevatedButton.styleFrom(
                                              primary: ColorConstants.RED),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('HAYIR'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  'HESABI SİL',
                                  style: TextStyle(
                                    color: ColorConstants.RED,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      }*/
                    }
                  }
                  return Text(
                      'Hata Oluştu Lütfen Daha Sonra Tekrar Deneyiniz.');
                }),
      ),
    );
  }
}
