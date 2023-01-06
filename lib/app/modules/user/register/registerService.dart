import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

registerUser(String nama, String noTelp, String email, String Pass) {
  User? userid = FirebaseAuth.instance.currentUser;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  ref.doc(userid!.uid).set({
    'email': email,
    'nama_lengkap': nama,
    'no_tlp': noTelp,
    'Password': Pass,
    'role': 'user'
  });
}
