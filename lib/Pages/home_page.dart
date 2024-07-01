import 'package:flutter/material.dart';
import 'package:music_player/Components/drawerr.dart';
import 'package:music_player/Models/playlist_provider.dart';
import 'package:music_player/Models/song.dart';
import 'package:music_player/Pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'Home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Get the PlaylistProvider
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  //   get playlistProvider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);

  }

  // Got to song Method

  void goToSong(int songIndex){

    playlistProvider.currentSongIndex = songIndex;


    Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(),));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("P L A Y   L  I S T",style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu, // Change this to the icon you want
              color: Theme.of(context).colorScheme.primary, // Change this to the color you want
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Darwerr(),
      body: Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            // Get the playlist
            final List<Song> playlist = value.playlist;

            return ListView.builder(
              itemCount: playlist.length,

                itemBuilder: (context, index){
                  // get indual song
                  final Song song = playlist[index];

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(

                      title: Text(song.songName,style: TextStyle(fontSize: 20),),
                      subtitle: Text(song.artistName),
                      leading: Image.asset(song.albumArtImagePath),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),

                      tileColor: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Set desired corner radius
                      ),
                      onTap: () => goToSong(index),
                    ),
                  );
                }
              );
          },
              ));
  }
}
