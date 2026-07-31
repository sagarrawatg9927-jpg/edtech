import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.deepPurple.withOpacity(0.1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.code, size: 80, color: Colors.deepPurple),
                      const SizedBox(height: 16),
                      Text(
                        'Flutter Complete Course',
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats row
                  Row(
                    children: [
                      _InfoChip(icon: Icons.play_circle, text: '24 Lessons'),
                      const SizedBox(width: 16),
                      _InfoChip(icon: Icons.timer, text: '12 Hours'),
                      const SizedBox(width: 16),
                      _InfoChip(icon: Icons.star, text: '4.8 Rating'),
                      const SizedBox(width: 16),
                      _InfoChip(icon: Icons.people, text: '1.2k Students'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'About This Course',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn Flutter from scratch and build beautiful mobile applications. This course covers everything from basic widgets to advanced state management.',
                    style: TextStyle(color: Colors.grey[600], height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  // What you'll learn
                  const Text(
                    "What You'll Learn",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _LearningPoint('Build beautiful UI with Flutter widgets'),
                  _LearningPoint('State management with Riverpod'),
                  _LearningPoint('Firebase integration'),
                  _LearningPoint('Deploy to App Store & Play Store'),
                  _LearningPoint('Build 5 real-world projects'),

                  const SizedBox(height: 20),

                  // Curriculum
                  const Text(
                    'Curriculum',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  ...List.generate(5, (index) {
                    return ExpansionTile(
                      title: Text('Chapter ${index + 1}: Topic Name'),
                      subtitle: Text('${index + 3} lessons'),
                      children: List.generate(
                        index + 2,
                        (lessonIndex) => ListTile(
                          leading: const Icon(Icons.play_circle_outline, size: 20),
                          title: Text('Lesson ${lessonIndex + 1}'),
                          subtitle: const Text('10:00 min'),
                          trailing: const Icon(Icons.lock_open, size: 16, color: Colors.green),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/video',
                              arguments: {
                                'url': 'https://youtube.com/watch?v=example',
                                'title': 'Lesson ${lessonIndex + 1}',
                              },
                            );
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom enroll button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '₹499',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'One-time payment',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Payment logic
                    },
                    child: const Text(
                      'Enroll Now',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

class _LearningPoint extends StatelessWidget {
  final String text;
  const _LearningPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
