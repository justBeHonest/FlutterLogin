import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/Constants/data_base_constants.dart';
import 'package:untitled1/Models/user_informations.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// GİRİŞ YAP METHODU  (SIGN IN)
  Future<UserInformations> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    var veri = await _firestore
        .collection(DataBaseConstants.DB_KULLANICILAR_COLLECTION_NAME)
        .doc(email)
        .get();
    UserInformations ui = UserInformations(
      email: veri[DataBaseConstants.DB_EMAIL_FIELD],
      password: veri[DataBaseConstants.DB_PASSWORD_FIELD],
      ad: veri[DataBaseConstants.DB_NAME_FIELD],
      pictureUrl: veri[DataBaseConstants.DB_PICTURE_URL_FIELD],
      soyad: veri[DataBaseConstants.DB_LAST_NAME_FIELD],
    );
    return ui;
  }

  /// ÇIKIŞ YAP METHODU  (SIGN OUT)
  signOut() async {
    return await _auth.signOut();
  }

  /// YENİ KULLANICI OLUŞTURMA METHODU  (SIGN UP)
  Future<User?> singUp({
    required String ad,
    required String soyad,
    required String email,
    required String password,
    required String pictureUrl,
  }) async {
    try {
      var user;
      user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      /// KULLANICILAR COLLECTION DOCUMENT EKLEME
      await _firestore
          .collection(DataBaseConstants.DB_KULLANICILAR_COLLECTION_NAME)
          .doc(email)
          .set({
        DataBaseConstants.DB_NAME_FIELD: ad,
        DataBaseConstants.DB_PASSWORD_FIELD: password,
        DataBaseConstants.DB_LAST_NAME_FIELD: soyad,
        DataBaseConstants.DB_EMAIL_FIELD: email,
        DataBaseConstants.DB_PICTURE_URL_FIELD: pictureUrl,
        'uid': user.user.uid,
      });
      return user.user;
    } catch (error) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getKullanicilar() {
    var ref = _firestore
        .collection(DataBaseConstants.DB_KULLANICILAR_COLLECTION_NAME)
        .snapshots();
    return ref;
  }

  Future<void> updateName({required Map currentUserInfo,required String newData}) async {
    print('*************************');
    print('${currentUserInfo[DataBaseConstants.DB_EMAIL_FIELD]}');
    print('*************************');
    await _firestore
        .collection(DataBaseConstants.DB_KULLANICILAR_COLLECTION_NAME)
        .doc(currentUserInfo[DataBaseConstants.DB_EMAIL_FIELD])
        .update({DataBaseConstants.DB_NAME_FIELD : newData});
  }
  Future<void> updateLastName({required Map currentUserInfo,required String newData}) async {
    await _firestore
        .collection(DataBaseConstants.DB_KULLANICILAR_COLLECTION_NAME)
        .doc(currentUserInfo[DataBaseConstants.DB_EMAIL_FIELD])
        .update({DataBaseConstants.DB_LAST_NAME_FIELD : newData});
  }
}
