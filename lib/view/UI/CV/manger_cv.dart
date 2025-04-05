import 'package:flutter/material.dart';



class MangerCV extends StatefulWidget {
  const MangerCV({super.key});

  @override
  _MangerCVState createState() => _MangerCVState();
}

class App {
  final String id;
  final String name;
  final String imageUrl;
  final String version;
  final double rating;
  final String size;
  final String developer;
  final String description;
  bool isInstalled;
  bool isInstalling;
  double downloadProgress;

  App({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.version,
    required this.rating,
    required this.size,
    required this.developer,
    required this.description,
    this.isInstalled = false,
    this.isInstalling = false,
    this.downloadProgress = 0.0,
  });
}

class _MangerCVState extends State<MangerCV>  {
  
  void _downloadCV() {
    showDialog(
      context: context,
      builder: (context) {
        bool downloading = true;
        double progress = 0.0;
        
        return StatefulBuilder(
          builder: (context, setState) {
            // Start download simulation
            if (downloading && progress < 1.0) {
              Future.delayed(const Duration(milliseconds: 500), () {
                if (progress < 1.0) {
                  setState(() {
                    progress += 0.1;
                  });
                } else {
                  setState(() {
                    downloading = false;
                  });
                }
              });
            }
            
            return AlertDialog(
              title: const Text('CV Download'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (downloading) 
                    Column(
                      children: [
                        const Text('Downloading CV...'),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(value: progress),
                        const SizedBox(height: 8),
                        Text('${(progress * 100).toInt()}%'),
                      ],
                    )
                  else
                    const Text('CV Downloaded Successfully!'),
                ],
              ),
              actions: [
                if (!downloading)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _readCV() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CVViewPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Store Profile'),
        
      ),
      body: _buildCVTab(),                
    );
  }
  Widget _buildCVTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile image
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://scontent.fcai19-12.fna.fbcdn.net/v/t39.30808-6/366177644_3562629257389830_5409391780022862858_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=mSQCFI5t34AQ7kNvgF-Umbr&_nc_oc=AdmYxYTYtEf7e0vGIEm8_KPnpqR7N2ai-jLOM2C1uSSD9dH4Sk7uB7CWFohf7nigDGQ&_nc_zt=23&_nc_ht=scontent.fcai19-12.fna&_nc_gid=Y6Uv6eZkzSMcEDmKZBCZKQ&oh=00_AYFTYzDTYV8K95QWSXNcMrURmHsyHW6J3rXK0j5mKW-_rA&oe=67EF12B7'),
            ),
            const SizedBox(height: 24),
            // Name
            const Text(
              'Your Name',
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Title
            const Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 36),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _downloadCV,
                    icon: const Icon(Icons.download),
                    label: const Text('Download CV'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _readCV,
                    icon: const Icon(Icons.visibility),
                    label: const Text('Read CV'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            // Quick info
            const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.blue),
                        SizedBox(width: 12),
                        Text('your.email@example.com'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.blue),
                        SizedBox(width: 12),
                        Text('+1 (123) 456-7890'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue),
                        SizedBox(width: 12),
                        Text('City, Country'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class AppDetailsPage extends StatelessWidget {
  final App app;
  final VoidCallback onInstall;
  final VoidCallback onUninstall;

  const AppDetailsPage({
    super.key,
    required this.app,
    required this.onInstall,
    required this.onUninstall,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App banner
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                app.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App title and rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          app.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (app.rating > 0)
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              app.rating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Developer info
                  Text(
                    'By ${app.developer} • Version ${app.version}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  // Install button
                  if (app.isInstalling)
                    Column(
                      children: [
                        LinearProgressIndicator(value: app.downloadProgress),
                        const SizedBox(height: 8),
                        Text(
                          'Downloading... ${(app.downloadProgress * 100).toInt()}%',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: app.isInstalled ? onUninstall : onInstall,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: app.isInstalled ? Colors.red : Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          app.isInstalled ? 'UNINSTALL' : 'INSTALL',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  // App details
                  const Text(
                    'About this app',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    app.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // App info
                  _buildInfoRow('Size', app.size),
                  _buildInfoRow('Current Version', app.version),
                  _buildInfoRow('Developer', app.developer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}

class CVViewPage extends StatelessWidget {
  const CVViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('CV Downloaded')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing CV...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://scontent.fcai19-12.fna.fbcdn.net/v/t39.30808-6/366177644_3562629257389830_5409391780022862858_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=mSQCFI5t34AQ7kNvgF-Umbr&_nc_oc=AdmYxYTYtEf7e0vGIEm8_KPnpqR7N2ai-jLOM2C1uSSD9dH4Sk7uB7CWFohf7nigDGQ&_nc_zt=23&_nc_ht=scontent.fcai19-12.fna&_nc_gid=Y6Uv6eZkzSMcEDmKZBCZKQ&oh=00_AYFTYzDTYV8K95QWSXNcMrURmHsyHW6J3rXK0j5mKW-_rA&oe=67EF12B7'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Software Developer',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'your.email@example.com | +1 (123) 456-7890',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            
            // Summary
            _buildSection(
              title: 'Professional Summary',
              content: 'Experienced software developer with expertise in mobile application development. '
                  'Passionate about creating intuitive user interfaces and solving complex problems. '
                  'Strong background in Flutter, React Native, and native Android development.',
            ),
            
            // Skills
            _buildSection(
              title: 'Skills',
              content: '',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Flutter',
                  'Dart',
                  'Android',
                  'iOS',
                  'React Native',
                  'JavaScript',
                  'Firebase',
                  'Git',
                  'UI/UX Design',
                  'REST APIs',
                ].map((skill) => Chip(
                  label: Text(skill),
                  //backgroundColor: Colors.blue[50],
                )).toList(),
              ),
            ),
            
            // Experience
            _buildSection(
              title: 'Work Experience',
              content: '',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExperienceItem(
                    title: 'Senior Mobile Developer',
                    company: 'Tech Solutions Inc.',
                    period: 'Jan 2022 - Present',
                    description: '• Developed and maintained multiple Flutter applications\n'
                        '• Led a team of 5 developers\n'
                        '• Implemented CI/CD pipelines\n'
                        '• Reduced app crash rate by 80%',
                  ),
                  const SizedBox(height: 16),
                  _buildExperienceItem(
                    title: 'Mobile Developer',
                    company: 'App Innovators',
                    period: 'Mar 2019 - Dec 2021',
                    description: '• Created cross-platform applications using Flutter\n'
                        '• Integrated third-party APIs and services\n'
                        '• Optimized app performance\n'
                        '• Collaborated with design team',
                  ),
                ],
              ),
            ),
            
            // Education
            _buildSection(
              title: 'Education',
              content: '',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExperienceItem(
                    title: 'Bachelor of Science in Computer Science',
                    company: 'University of Technology',
                    period: '2015 - 2019',
                    description: 'GPA: 3.8/4.0\n'
                        'Specialization in Mobile Computing',
                  ),
                ],
              ),
            ),
            
            // Certifications
            _buildSection(
              title: 'Certifications',
              content: '',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListItem('Google Associate Android Developer'),
                  _buildListItem('Flutter Development Bootcamp'),
                  _buildListItem('AWS Certified Developer'),
                ],
              ),
            ),
            
            // Projects
            _buildSection(
              title: 'Selected Projects',
              content: '',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExperienceItem(
                    title: 'E-commerce Mobile App',
                    company: 'Personal Project',
                    period: '2023',
                    description: 'Built a fully functional e-commerce app using Flutter and Firebase.',
                  ),
                  const SizedBox(height: 16),
                  _buildExperienceItem(
                    title: 'Health Tracking App',
                    company: 'Client Project',
                    period: '2022',
                    description: 'Developed a health tracking application with custom animations and charts.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    Widget? child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        if (content.isNotEmpty) Text(content, style: const TextStyle(fontSize: 16)),
        if (child != null) child,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildExperienceItem({
    required String title,
    required String company,
    required String period,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              company,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              period,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(description),
      ],
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}