import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices
{
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> readUser() async
  {
    DocumentSnapshot documentSnapshot = await usersCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    return documentSnapshot;
  }

  updatefavorites(List favorites)
  {
    usersCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({'favorites': favorites});
  }
}
