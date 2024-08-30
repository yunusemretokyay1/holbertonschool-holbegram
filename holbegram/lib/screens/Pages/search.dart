import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holbegram/widgets/text_field.dart';
// firebase stuff
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/screens/Pages/methods/post_storage.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();
  List<Post>? _searchResult;

  Future<void> submitSearch() async {
    final List<Post> searchResult = await PostStorage().searchPosts(searchController.text);
    setState(() {
      _searchResult = searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_searchResult == null) {
      submitSearch();
    }

    Widget resultsStaggeredGrid = const Center(child: Text('loading...'));

    if (_searchResult != null) {
      List<StaggeredGridTile> imageTiles = <StaggeredGridTile>[];
      
      for (final Post post in _searchResult!) {
        String postImageUrl = post.postUrl;
        Widget image;

        try {
          image = Image.network(postImageUrl);
        } catch (error) {
          image = Text('Error loading image: $error');
        }

        StaggeredGridTile imageTile = StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: image,
        );

        imageTiles.add(imageTile);
      }

      resultsStaggeredGrid = StaggeredGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: imageTiles,
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: [
              TextFieldInput(
                controller: searchController,
                onSubmitted: (p0) {
                  print("Search 'TextFieldInput' submitted!\np0: $p0");
                  submitSearch();
                },
                isPassword: false,
                hintText: 'Search',
                keyboardType: TextInputType.text,
                prefixIcon: IconButton(
                  onPressed: submitSearch,
                  icon: const Icon(Icons.search_outlined),
                ),
                filled: true,
              ),
            ],
          ),
          resultsStaggeredGrid,
        ],
      ),
    );
  }
}
