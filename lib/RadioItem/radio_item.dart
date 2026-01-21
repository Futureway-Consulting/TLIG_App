import 'package:audioplayers/audioplayers.dart';
class RadioStation {
  final int id;
  final String? name;
  final String? streamUrl;
  final String? coverUrl;

  RadioStation({
    required this.id,
    this.name,
    this.streamUrl,
    this.coverUrl,
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      id: json['id']?? DateTime.now().millisecondsSinceEpoch, 
      name: json['name']?? Null,
      streamUrl: json['streamUrl']?? Null,
      coverUrl: json['coverImage']?? Null,
    );
  }
}


class RadioPlayerController {
  final AudioPlayer _player = AudioPlayer();
  final String url = "https://stream.tligradio.org/listen/english/radio.mp3";

  Future<void> play() async {
    final source = UrlSource(url);
    await _player.play(source);
  }

  Future<void> pause() async {
    await _player.pause();
  }

  void dispose() {
    _player.dispose();
  }
}
