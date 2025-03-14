import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CleaningPhoto {
  final String beforeImageUrl;
  final String afterImageUrl;
  final DateTime date;
  final String location;
  final String description;

  CleaningPhoto({
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.date,
    required this.location,
    required this.description,
  });
}

class CleaningPhotosScreen extends StatefulWidget {
  const CleaningPhotosScreen({Key? key}) : super(key: key);

  @override
  State<CleaningPhotosScreen> createState() => _CleaningPhotosScreenState();
}

class _CleaningPhotosScreenState extends State<CleaningPhotosScreen> {
  final List<CleaningPhoto> _photos = [
    CleaningPhoto(
      beforeImageUrl: 'https://example.com/before1.jpg',
      afterImageUrl: 'https://example.com/after1.jpg',
      date: DateTime.now().subtract(const Duration(days: 1)),
      location: 'Kitchen',
      description: 'General kitchen cleaning',
    ),
    CleaningPhoto(
      beforeImageUrl: 'https://example.com/before2.jpg',
      afterImageUrl: 'https://example.com/after2.jpg',
      date: DateTime.now().subtract(const Duration(days: 3)),
      location: 'Bathroom',
      description: 'Bathroom cleaning',
    ),
  ];

  void _showPhotoSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickPhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _takePhoto() {
    // TODO: Implement taking a photo
  }

  void _pickPhoto() {
    // TODO: Implement picking a photo from gallery
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Photos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () => _showPhotoSourceDialog(),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photo.location,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        photo.description,
                        style: TextStyle(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${photo.date.day}.${photo.date.month}.${photo.date.year}',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.photo_camera,
                                size: 48,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Before',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.photo_camera,
                                size: 48,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'After',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 