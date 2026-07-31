import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String lessonTitle;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.lessonTitle,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();

    // YouTube video ID nikalna
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.lessonTitle,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? const Color(0xFF6C63FF) : Colors.white,
            ),
            onPressed: () {
              setState(() => _isBookmarked = !_isBookmarked);
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Download feature
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Player
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: const Color(0xFF6C63FF),
            progressColors: const ProgressBarColors(
              playedColor: Color(0xFF6C63FF),
              handleColor: Color(0xFF6C63FF),
            ),
          ),

          // Notes & Discussion tabs
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: const TabBar(
                      labelColor: Color(0xFF6C63FF),
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Notes'),
                        Tab(text: 'Discussion'),
                        Tab(text: 'Resources'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: TabBarView(
                        children: [
                          // Notes Tab
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: [
                              _NoteCard(
                                title: 'Key Points',
                                content: '• Important concept 1\n• Important concept 2\n• Remember this formula',
                              ),
                              _NoteCard(
                                title: 'Summary',
                                content: 'This lesson covers the basics of the topic. Make sure to practice the exercises.',
                              ),
                            ],
                          ),
                          // Discussion Tab
                          const Center(
                            child: Text('Discussion coming soon...',
                                style: TextStyle(color: Colors.grey)),
                          ),
                          // Resources Tab
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: [
                              ListTile(
                                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                                title: const Text('Lesson Notes PDF'),
                                trailing: const Icon(Icons.download),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(Icons.quiz, color: Colors.orange),
                                title: const Text('Practice Quiz'),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                onTap: () {
                                  Navigator.pushNamed(context, '/quiz');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _NoteCard extends StatelessWidget {
  final String title;
  final String content;

  const _NoteCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(color: Colors.grey[600], height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
