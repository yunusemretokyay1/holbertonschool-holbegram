import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  String caption;
  String uid;
  String username;
  List likes;
  String postId;
  DateTime datePublished;
  String postUrl;
  String profImage;

  /// Assuming that `snap.data()` is a JSON representation of a `Post`
  /// (Map<String field_key, dynamic field_value>),
  /// this method returns the `Post` representation of `snap.data()`.
  ///
  /// Throws if `snap.data()` is null, or if its fields are missing, null or the incorrect type.
  static Post fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final Map<String, dynamic> data = snap.data()!;

    dynamic datePublished = data['datePublished'];

    if (datePublished is Timestamp) {
      datePublished = datePublished.toDate();
    }
  
    return Post(
      caption: data['caption'],
      uid: data['uid'],
      username: data['username'],
      likes: data['likes'],
      postId: data['postId'],
      datePublished: datePublished,
      postUrl: data['postUrl'],
      profImage: data['profImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'caption': caption,
    'uid': uid,
    'username': username,
    'likes': likes,
    'postId': postId,
    'datePublished': datePublished,
    'postUrl': postUrl,
    'profImage': profImage,
  };
}
