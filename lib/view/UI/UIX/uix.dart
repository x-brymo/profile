import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile/view/UI/UIX/provider/provider.dart';
import 'package:profile/view/UI/UIX/widgets/DetailsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class UIXScreen extends ConsumerWidget {
  const UIXScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(filteredProjectsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final categories = ['All', 'Mobile', 'Web', 'Packages', 'Desktop', 'UI/UX', 'Tools', 'Education'];

    return Scaffold(
      appBar: AppBar(title: const Text('List Projects')),
      body: Column(
        children: [
          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    width: 100,
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(selectedCategoryProvider.notifier).state = cat;
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Projects List
          Expanded(
            child: projects.isEmpty
                ? const Center(child: Text("No projects available"))
                : ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return _buildCard(
                        imageUrl: project.previewImageUrl,
                        context: context,
                        tags: project.tags ?? [],
                        tool: project.category,
                        stars: 5, // You can replace with actual stars if available
                        githubUrl: project.githubUrl,
                        onPreview: () {
                          // Preview action, for example navigate to the DetailsPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectDetailsPage(project: project),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String imageUrl,
    required BuildContext context,
    required List<String> tags,
    required String tool,
    required int stars,
    required String githubUrl,
    required VoidCallback onPreview,
  }) {
    return SizedBox(
      height: 300,
      width: 250,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Text("Image not available"),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              // Tags
              Wrap(
                spacing: 6,
                runSpacing: -8,
                children: tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          //backgroundColor: Colors.blue.shade100,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 4),
              
              // Tool Category
              Text("Tool: $tool", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),

              // Star rating, GitHub icon, and Preview icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('$stars'),
                    ],
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.github),
                    tooltip: 'View on GitHub',
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(githubUrl))) {
                        await launchUrl(Uri.parse(githubUrl));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch GitHub URL')),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.code),
                    tooltip: 'Preview Code',
                    onPressed: onPreview,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
