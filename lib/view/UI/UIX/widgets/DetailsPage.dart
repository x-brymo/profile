import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/domain/models/projects_model.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  final UIXProject project;
  const ProjectDetailsPage({required this.project, super.key});

  @override
  ConsumerState<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  bool isDownloading = false;

  void simulateDownload() async {
    setState(() => isDownloading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isDownloading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download complete!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: project.title,
            child: Image.network(project.previewImageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(project.description),
          ),
          const Spacer(),
          Center(
            child: isDownloading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text("Download"),
                    onPressed: simulateDownload,
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
