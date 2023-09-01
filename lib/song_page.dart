import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_library/controls.dart';
import 'package:music_library/new_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SongPage> {
  late AudioPlayer _audioPlayer;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()
      ..setUrl(
          "https://cf-media.sndcdn.com/r1fQeRkIn5i8.128.mp3?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiKjovL2NmLW1lZGlhLnNuZGNkbi5jb20vcjFmUWVSa0luNWk4LjEyOC5tcDMqIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNjkzNTgxMzE0fX19XX0_&Signature=MIiY4Nvo-d074QJxcBHth5~jjgBoo5sKHe2Mu59hAdt24ZngmwpW~~lme10ONEpct1bAc5msZgGC7Cle~VMvJWL7cgNSjrBfFE6SopyhfSjjuyFTusgb7aYBy-brlnHyFvCagPyYOdjH8X6CDeS4fbs6jMmuEuNMbzad0qv7PSAMeQbFK7mYK4-l~m3aznXqJVw9bvr7~fgjX4JKWu44xeK2bwVv7MJuSLG9hbNCK~VcMlFuj~PiRq1LmLOqoT2keAqGYSEiKUjFytCNqMY17wzdo49YgJmRBHvV8cc-CHB670KKv3zbzrqFnQrgAgYaxgNCENQ-61da3vqDsgp02g__&Key-Pair-Id=APKAI6TU7MMXM5DG6EPQ");
  }

  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: NewBox(child: Icon(Icons.arrow_back)),
                  ),
                  Text("S O N G   F O R   Y O U"),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: NewBox(child: Icon(Icons.menu)),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              NewBox(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/en/2/2a/2014ForestHillsDrive.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "J Cole",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey.shade700),
                              ),
                              const Text(
                                "Wet Dreamz",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Controls().playButton(_audioPlayer)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
