import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/screens/Pages/methods/post_storage.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Users? _user;
  List<Post>? _results;

  Future<void> fetchUser() async {
    final Users? user = await AuthMethods().getUserDetails();
    setState(() {
      _user = user;
    });
  }

  Future<void> fetchFavorites() async {
    if (_user == null) return;

    const List<Post> results = <Post>[];

    for (final String postId in _user!.saved) {
      Post? post = await PostStorage().getPostById(postId);
      if (post == null) continue;

      results.add(post);
    }
    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_user == null) {
      body = const Center(child: Text("Fetching user..."));
      fetchUser();
    } else if (_results == null) {
      body = const Center(child: Text("Fetching favorites...")); 
      fetchFavorites();
    } else {
      body = ListView.builder(
        itemCount: _results!.length,
        itemBuilder: (BuildContext context, int index) {
          try {
            return SizedBox(
              width: double.infinity,
              child: Image.network(_results![index].postUrl),
            ); 
          } catch (error) {
            return const Text('Error fetching image...');
          }
        }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Holbegram',
          style: TextStyle(fontFamily: 'Billabong', fontSize: 40),
        ),
      ),
      body: body,
    );
  }
}
