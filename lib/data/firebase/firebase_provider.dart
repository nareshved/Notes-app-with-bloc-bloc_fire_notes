import 'dart:developer';

import 'package:bloc_fire_notes/domain/models/note_model/note_model.dart';
import 'package:bloc_fire_notes/repository/widgets/home/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user_model/user_model.dart';

class FirebaseProvider {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseStorage = FirebaseStorage.instance;
  static final firebaseFireStore = FirebaseFirestore.instance;
  static final firebaseCurrentUser = FirebaseAuth.instance.currentUser!.uid;

  /// firebase collections

  static const String collectionUsers = "users";
  static const String collectionNotes = "notes";
  static const String collectionUserProfile = "profile";
  static const String collectionUserProfilePhotos = "photos";

  /// shared prefs
  static const String loginPrefsKey = "isLogin";

// firebase functions

  Future<void> createUser(
      {required UserModel mUser, required String mPass}) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: mUser.email, password: mPass);

      /// create user collection in firestore
      if (credential.user != null) {
        firebaseFireStore
            .collection(collectionUsers)
            .doc(credential.user!.uid)
            .set(mUser.toDoc())
            .then((value) {})
            .onError((error, stackTrace) {
          log("Error: $error");
          throw Exception("Error: $error");
        });
      }
    } on FirebaseException catch (e) {
      log("Error in firebase provider page : $e");

      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("The account already exists for that email");
      }

      // throw Exception("Error: $e");
    }
  }

  Future<void> authenticateUser(
      {required mEmail,
      required String mPass,
      required BuildContext context}) async {
    try {
      final UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: mEmail, password: mPass);

      if (credential.user != null) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(loginPrefsKey, credential.user!.uid);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeBottomNavbar(),
            ));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Wrong password provided for that user.");
      }

      throw Exception("Wrong Email or password please check");
    } catch (e) {
      log("user login failed error ${e.toString()}");
    }
  }

  static Future<void> addNote(NoteModel addNewNote) async {
    //notes collection
    return await firebaseFireStore
        .collection(collectionUsers)
        .doc(firebaseCurrentUser)
        .collection(collectionNotes)
        .add(addNewNote.toDoc())
        .then((value) {
      log("note added and collection created");
    }).onError(
      (error, stackTrace) {
        log("Error: $error");
        throw Exception("Error: $error");
      },
    );
  }

  // get notes from firebase

  static Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    return firebaseFireStore
        .collection(collectionUsers)
        .doc(firebaseCurrentUser)
        .collection("notes")
        .snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getNotesUsers() async {
    var user = await firebaseFireStore.collection(collectionUsers).get();
    log(user.docs.toString());

    return await firebaseFireStore.collection(collectionUsers).get();
  }

  static Future<void> updateNotes(String noteId, NoteModel updatedNote) async {
    return await firebaseFireStore
        .collection(collectionUsers)
        .doc(firebaseCurrentUser)
        .collection(collectionNotes)
        .doc(noteId)
        .update(updatedNote.toDoc());
  }

  static Future<void> deleteNote(String noteId) async {
    return await firebaseFireStore
        .collection(collectionUsers)
        .doc(firebaseCurrentUser)
        .collection(collectionNotes)
        .doc(noteId)
        .delete();
  }
}


// home / notes

// FirebaseProvider.firebaseFireStore
//             .collection("users")
//             .doc(FirebaseProvider.firebaseCurrentUser)
//             .collection("notes")
//             .snapshots()
