import 'package:flutter/material.dart';
import 'package:users_posts_project/class/album_repository.dart';
import 'package:users_posts_project/model/album/album_info.dart';
import 'package:users_posts_project/screens/album_info/album_info_screen.dart';
import 'package:users_posts_project/widgets/table_widget.dart';

class AllAlbumsScreen extends StatefulWidget {
  AllAlbumsScreen({required this.userId});
  final int userId;

  @override
  _AllAlbumsScreenState createState() => _AllAlbumsScreenState();
}

class _AllAlbumsScreenState extends State<AllAlbumsScreen> {
  double get _deviceSizeWidth => MediaQuery.of(context).size.width;

  int? get _userId => widget.userId;

  late List<AlbumInfo> album;
  AlbumRepository get albumRepository => _albumRepository;
  AlbumRepository _albumRepository = AlbumRepository();
  @override
  void initState() {
    super.initState();
    album = [];
    getAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text("ALBUMS"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            for (int i = 0; i < album.length; i++)
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AlbumInfoScreen(albumId: album[i].id!))),
                child: TableWidget(
                  text1: "${i + 1}",
                  text2: "${album[i].title}",
                  sizeWidth: _deviceSizeWidth / 5,
                ),
              ),
          ]),
        ));
  }

  Future<void> getAlbum() async {
    album.addAll(await albumRepository.getAlbum(_userId!));
    setState(() {
      album = album;
    });
  }
}
