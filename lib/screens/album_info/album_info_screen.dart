import 'package:flutter/material.dart';
import 'package:users_posts_project/class/album_repository.dart';
import 'package:users_posts_project/model/album/photo_model.dart';

class AlbumInfoScreen extends StatefulWidget {
  AlbumInfoScreen({required this.albumId});
  final int? albumId;
  @override
  _AlbumInfoScreenState createState() => _AlbumInfoScreenState();
}

class _AlbumInfoScreenState extends State<AlbumInfoScreen> {
  double get _deviceSizeHeight => MediaQuery.of(context).size.height;
  int? get _albumId => widget.albumId;

  late List<Photo> photos;
  AlbumRepository get albumRepository => _albumRepository;
  AlbumRepository _albumRepository = AlbumRepository();
  @override
  void initState() {
    super.initState();
    photos = [];
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text("PHOTOS"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
          height: _deviceSizeHeight,
          child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: [
                for (int i = 0; i < photos.length; i++)
                  Card(
                    child: Image.network("${photos[i].url}"),
                  ),
              ]),
        )));
  }

  Future<void> getPhotos() async {
    photos.addAll(await albumRepository.getPhosts(_albumId!));
    setState(() {
      photos = photos;
    });
  }
}
