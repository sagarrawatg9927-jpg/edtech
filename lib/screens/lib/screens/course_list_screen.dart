import 'package:flutter/material.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  String _selectedSubject = 'All';
  String _selectedLevel = 'All';

  final List<String> _subjects = [
    'All', 'Mathematics', 'Science', 'English', 'Coding', 'History'
  ];
  
  final List<String> _levels = [
    'All', 'Beginner', 'Intermediate', 'Advanced'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Subject Filter Chips
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _subjects.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                final isSelected = _selectedSubject == subject;
                return FilterChip(
                  label: Text(subject),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() => _selectedSubject = subject);
                  },
                  selectedColor: const Color(0xFF6C63FF).withOpacity(0.2),
                  checkmarkColor: const Color(0xFF6C63FF),
                );
              },
            ),
          ),

          // Course Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/course-detail',
                        arguments: 'course_$index',
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Course thumbnail
                        Container(
                          height: 100,
                          color: [
                            Colors.deepPurple,
                            Colors.teal,
                            Colors.orange,
                            Colors.pink,
                            Colors.blue,
                            Colors.indigo,
                          ][index % 6].withOpacity(0.15),
                          child: Center(
                            child: Icon(
                              [
                                Icons.code,
                                Icons.calculate,
                                Icons.biotech,
                                Icons.language,
                                Icons.history,
                                Icons.computer,
                              ][index % 6],
                              size: 40,
                              color: [
                                Colors.deepPurple,
                                Colors.teal,
                                Colors.orange,
                                Colors.pink,
                                Colors.blue,
                                Colors.indigo,
                              ][index % 6],
                            ),
                          ),
                        ),

                        // Course info
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Course Title ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '24 Lessons',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 14, color: Colors.amber[600]),
                                  Text(
                                    ' 4.8',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    index % 3 == 0 ? 'Free' : '₹${(index + 1) * 499}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: index % 3 == 0 ? Colors.green : null,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
