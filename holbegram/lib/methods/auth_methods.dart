import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import '../models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({required String email, required String password}) async {
    if (email == '' || password == '') {
      return 'Please fill all the fields';
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (error) {
      return error.code;
    } catch (error) {
      return 'unexpected error: $error';
    }
  }

  Future<String> signUpUser({required String email, required String password, required String username, Uint8List? file}) async {
    if (email == '' || password == '' || username == '') {
      return 'Please fill all the fields';
    }

    final Users userModel;

    try {
      // Signing-up user in Firebase Auth and making sure the Sign-up response is as expected.
      // The response should contain the user's uid and email:
      // (the uid is like a primary key for this user)
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user == null || user.email == null) {
        return 'No userCredential.user or userCredential.user.email recieved from the sign-up server reply';
      }

      // Storing user's chosen profile picture in Firebase Cloud Storage,
      // and getting the picture's URL for the user's model:

      String profilePictureUrl = '';

      if (file != null) {
        profilePictureUrl = await StorageMethods().uploadImageToStorage(false, StorageMethods.childName, file);
      }

      // Constructing user's model to have the user's profile picture URL,
      // FirebaseAuth uid and email, and blank other info,
      // and storing user's model in Cloud Firestore:
      userModel = Users(
        uid: user.uid,
        email: user.email!,
        username: username,
        bio: '',
        photoUrl: profilePictureUrl,
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: '',
      );
    } on FirebaseAuthException catch (error) {
      return error.code;
    } catch (error) {
      return 'unexpected error: $error';
    }

    try {
      await _firestore.collection('users').doc(userModel.uid).set(userModel.toJson());
    } catch (error) {
      return 'Error adding new user object to Cloud Firestore: $error';
    }

    return 'success';
  }

  Future<Users?> getUserDetails() async {
    User? user = _auth.currentUser;

    if (user == null) return null;

    try {
      DocumentSnapshot<Map<String, dynamic>> userModel = await _firestore.collection('users').doc(user.uid).get();
      return Users.fromSnap(userModel);
    } catch (error) {
      return null;
    }
  }

  /// Adds `postId` to the current user's `saved` `List`, in the Cloud Firestore.
  /// (This is where the user's "favorites" will be stored in).
  /// Returns 'Ok' if everything went as expected, or the error's code or string representation.
  Future<String> savePostById(String postId) async {
    final Users? user = await getUserDetails();
    if (user == null) {
      return 'No user found';
    }
    user.saved.add(postId);
    
    try {
      await _firestore.collection('users').doc(user.uid)
        .set(user.toJson());
    } on FirebaseAuthException catch (error) {
      return error.code;
    } catch (error) {
      return error.toString();
    }

    return 'Ok';
  }
}
