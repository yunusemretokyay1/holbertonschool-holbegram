import 'dart:typed_data';
import 'package:uuid/uuid.dart';
// firebase stuff
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  static const String childName = 'images';

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Assumes that there's already a current user signed in in `FirebaseStorage.instance`!!!
  /// Returns the image's download URL if everything goes well.
  Future<String> uploadImageToStorage(bool isPost, String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
