import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Models/song.dart';

class PlaylistProvider with ChangeNotifier {
  final List<Song> _playlist = [
    // Song 1
    Song(
        songName: "Last Ride",
        artistName: "Drake",
        albumArtImagePath: 'assets/images/image-1.jpg',
        audioPath: 'audio/audio-1.wav'),
    // Song 2
    Song(
        songName: "4 Am",
        artistName: "2 pac",
        albumArtImagePath: 'assets/images/image-2.jpg',
        audioPath: 'audio/audio-2.wav'),
    // Song 3
    Song(
        songName: "Doja cat",
        artistName: "Central Cee",
        albumArtImagePath: 'assets/images/image-3.jpg',
        audioPath: 'audio/audio-3.mp3'),
  ];

  // Current Song Index
  int? _currentSongIndex;

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // Initially not playing
  bool _isPlaying = false;

  // Play the song
  void play() async {
    if (_currentSongIndex != null) {
      final String path = _playlist[_currentSongIndex!].audioPath;
      await _audioPlayer.stop(); // stop current song
      await _audioPlayer.play(AssetSource(path));
      _isPlaying = true;
      notifyListeners();
    }
  }

  // Pause Current Song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume Playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Pause Or Resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  // Seek to specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // Go to the next song if it's not the last song
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        // If it is the last song, loop back to the 1st song
        _currentSongIndex = 0;
      }
      play();
    }
  }

  // Play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      // If more than 2 seconds have passed, replay the current song
      seek(Duration.zero);
      play();
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        // If it's the first song, loop back to the last song
        _currentSongIndex = _playlist.length - 1;
      }
      play();
    }
  }

  // Listen to the durations
  void listenToDuration() {
    // Listen for the total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // Listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // Listen for the song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
