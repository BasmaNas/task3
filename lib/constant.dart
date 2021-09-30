import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

CollectionReference adminsCollection =
    FirebaseFirestore.instance.collection('admins');
String adminId = FirebaseAuth.instance.currentUser.uid;

String adminEmail = FirebaseAuth.instance.currentUser.email;
