import 'dart:io';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/widgets/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BookDetailGallery extends StatelessWidget {
  const BookDetailGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Gallery",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.userData.gallery.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.userData.gallery.length) {
                      return _buildImageTile(context, state, index);
                    } else {
                      return _buildAddImageTile(context, state);
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageTile(
      BuildContext context, BookDetailState state, int index) {
    return GestureDetector(
      onTap: () => _showImageDialog(context, state.userData.gallery[index]),
      onLongPress: () => _showDeleteOption(context, state, index),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.file(
            File(state.userData.gallery[index]),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAddImageTile(BuildContext context, BookDetailState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
        child: IconButton(
          icon: const Icon(Icons.add_a_photo),
          onPressed: () => _showOptions(context, state),
          iconSize: 30,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (_) => ImageDialog(imagePath: imagePath),
    );
  }

  void _showDeleteOption(
      BuildContext context, BookDetailState state, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                state.deleteGalleryImage(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showOptions(BuildContext context, BookDetailState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(context, state, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(context, state, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(
      BuildContext context, BookDetailState state, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      await _saveImage(context, state, imageFile);
    }
  }

  Future<void> _saveImage(
      BuildContext context, BookDetailState state, File imageFile) async {
    try {
      final applicationDirectory = await getApplicationDocumentsDirectory();
      final path = applicationDirectory.path;
      final fileName =
          '${state.book.title}-${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File newImage = await imageFile.copy('$path/$fileName');

      state.addGalleryImage(newImage.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image: $e')),
      );
    }
  }
}
