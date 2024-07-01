import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/Components/NeuBox.dart';
import 'package:music_player/Models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}: $twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    print("SongPage build called");

    return Scaffold(
      body: Consumer<PlaylistProvider>(
          builder: (context, value, child){
            // Get the playlist
            final playlist = value.playlist;

            // Get the current song Index
            final currentSongIndex = value.currentSongIndex ?? 0;

            // Print statements for debugging
            print("Playlist length: ${playlist.length}");
            print("Current song index: $currentSongIndex");

            if (playlist.isEmpty || currentSongIndex >= playlist.length) {
              return Center(child: const Text("No song available"));
            }

            final currentSong = playlist[currentSongIndex];
            print("Current song: ${currentSong.songName}");

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  children: [
                    // App Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),

                        // Title
                        Text(
                          "S o n g",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Menu Button
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),

                    // After App Bar Column
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Album Art
                          NeuBox(
                            child: Column(
                              children: [
                                // Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(currentSong.albumArtImagePath),
                                ),

                                // Song and Artist Name
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Song and Artist Name
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2, top: 6, bottom: 2),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Song Name
                                            Text(
                                              currentSong.songName,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                            Text(currentSong.artistName)
                                          ],
                                        ),
                                      ),

                                      // Heart Icon
                                      const Icon(Icons.favorite_outline_rounded)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Sized Box
                          const SizedBox(
                            height: 10,
                          ),

                          // Song Duration
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 22.0, right: 22.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // start time
                                Text(formatTime(value.currentDuration)),

                                // Shuffle icon
                                const Icon(Icons.shuffle),

                                // repeat icon
                                const Icon(Icons.repeat),

                                // End TIME
                                Text(formatTime(value.totalDuration)),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            value: value.currentDuration.inSeconds.toDouble(),
                            activeColor: Colors.green,
                            onChanged: (double newValue) {
                              setState(() {
                                // Update the current duration while the user is sliding
                                value.seek(Duration(seconds: newValue.toInt()));
                              });
                            },
                            onChangeEnd: (double newValue) {
                              setState(() {
                                // Update the current duration when the user stops sliding
                                value.seek(Duration(seconds: newValue.toInt()));
                              });
                            },
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // Playback Controls
                          Row(
                            children: [
                              // Previous
                              Expanded(
                                child: GestureDetector(
                                  onTap: value.playPreviousSong,
                                  child: const NeuBox(child: Icon(Icons.skip_previous_rounded)),
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              // Pause
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: value.pauseOrResume,
                                  child: NeuBox(child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow)),
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              // Next
                              Expanded(
                                child: GestureDetector(
                                  onTap: value.playNextSong,
                                  child: const NeuBox(child: Icon(Icons.skip_next_rounded)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
