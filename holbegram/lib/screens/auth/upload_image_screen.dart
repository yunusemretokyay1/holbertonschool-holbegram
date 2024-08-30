import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:holbegram/methods/auth_methods.dart';

class AddPicture extends StatefulWidget {
  const AddPicture({super.key, required this.email, required this.password, required this.username});

  final String email;
  final String password;
  final String username;

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  // future user's profile image
  Uint8List? _image;

  // these should set `image`.
  Future<void> selectImage(ImageSource imageSource) async {
    // print('Selecting image from $imageSource...');
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: imageSource);
    // print('Selected image: $image');
    if (image != null) {
      // print('image name: ${image.name}; image path: ${image.path}');
      Uint8List imageBytes = await image.readAsBytes();
      // print('image bytes: $imageBytes');
      setState(() {
        // print('_image: $_image');
        _image = imageBytes;
        // print('_image: $_image');
      });
    }
  }

  void selectImageFromGallery() {
    selectImage(ImageSource.gallery);
  }

  void selectImageFromCamera() {
    selectImage(ImageSource.camera);
  }

  /// By this point, the user shouldn't have had their account created yet,
  /// because this screen selects their profile picture.
  /// Then, the "Next" button calls `AuthMethods().signUpUser`
  /// with the user's information from the previous page
  /// (`email`, `password`, `username`)
  /// and the selected image `_image`.
  ///
  /// If there's no selected `_image`, the default at
  /// `assets/images/Sample_User_Icon.png` will be used.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'Holbegram',
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 50,
            ),
          ),
          Image.asset(
            'assets/images/logo.webp',
            width: 80,
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Hello, ${widget.username} Welcome to Holbegram',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Choose an image from your gallery or take a new one.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: 200,
            child: Column(
              children: <Widget>[
                (
                  _image == null
                  ? Image.asset('assets/images/Sample_User_Icon.png')
                  : Image.memory(_image!)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: 40,
                      color: const Color.fromARGB(218, 226, 37, 24),
                      onPressed: selectImageFromGallery,
                      icon: const Icon(Icons.image_outlined),
                    ),
                    IconButton(
                      iconSize: 40,
                      color: const Color.fromARGB(218, 226, 37, 24),
                      onPressed: selectImageFromCamera,
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 40,
                  child: Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                        ),
                        onPressed: () {
                          // Sign up the user with `email`, `password`, `username`,
                          // and `_image` as the user's profile image
                          AuthMethods().signUpUser(
                            email: widget.email,
                            password: widget.password,
                            username: widget.username,
                            file: _image,
                          ).then((result) {
                            print('Sign up result: $result');

                            if (result == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Success!')),
                              );

                              /*
                              // TODO: FIGURE OUT HOW TO SWITCH THE SCREENS INSTEAD OF PUSHING
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const Home()
                                ),
                              ); */
                            }
                          });
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
