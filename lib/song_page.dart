import 'package:flutter/material.dart';
import 'package:music_library/modelData.dart';
import 'package:http/http.dart' as http;
import 'package:music_library/new_box.dart';
import 'dart:convert';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SongPage> {
  bool playArea = false; // Initialize playArea
  String name = '';
  String title = '';
  String image = '';
  String songUrl = '';
  Future<List<MyData>> loadItems() async {
    final url =
        Uri.https("music-librar-default-rtdb.firebaseio.com", "SongInfo.json");
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    List<MyData> loadedData = [];
    listData.forEach((key, value) {
      loadedData.add(MyData(
        link: value['link'],
        name: value['name'],
        title: value['title'],
        image: value['image'],
      ));
    });
    return loadedData;
  }

  @override
  void initState() {
    super.initState();
    loadItems().then((tracks) {
      if (tracks.isNotEmpty) {
        songUrl = tracks[0].link;
        name = tracks[0].name;
        image = tracks[0].image;
        title = tracks[0].title;
      }
    });
  }

  Widget playVideo() {
    if (songUrl != null && songUrl.isNotEmpty) {
      final YoutubePlayerController youtubePlayerController =
          YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(songUrl)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
        ),
      );
      return Container(
        width: 300,
        height: 400,
        child: YoutubePlayer(
          controller: youtubePlayerController,
          liveUIColor: Colors.amber,
        ),
      );
    } else {
      // Handle the case where songUrl is null or empty
      return const Text('Video URL is missing or invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: FutureBuilder<List<MyData>>(
            future: loadItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while data is being fetched
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle the error case
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Handle the case where no data is available
                return const Text('No data available');
              } else {
                // Data is available, update the variables
                final tracks = snapshot.data!;
                name = tracks[0].name;
                image = tracks[0].image;
                title = tracks[0].title;

                // Build the UI with the data
                return Column(
                  children: [
                    Column(
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
                                child: playArea == false
                                    ? Image.network(
                                        image,
                                        width: 400,
                                        height: 400,
                                      )
                                    : playVideo(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Text(
                                          title,
                                          style: const TextStyle(
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
                            children: [
                              NewBox(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // Toggle playArea when the button is pressed
                                      playArea = !playArea;
                                    });
                                  },
                                  iconSize: 80,
                                  icon: const Icon(Icons.play_arrow_rounded),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
