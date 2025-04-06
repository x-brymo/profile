// Sample project data
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/domain/models/UIXProject_model,dart';

final allProjectsProvider = Provider<List<UIXProject>>((ref) {
  return [
    UIXProject(
      title: 'Modern Mobile UI',
      category: 'Mobile',
      description: 'A sleek mobile UI built with Flutter.',
      previewImageUrl: 'https://via.placeholder.com/300',
      downloadUrl: 'https://example.com/mobile-ui.zip',
    ),
    UIXProject(
      title: 'Responsive Web UI',
      category: 'Web',
      description: 'A responsive web layout in Flutter.',
      previewImageUrl: 'https://github.com/',
      downloadUrl: 'https://example.com/web-ui.zip',
    ),
    // Add more here...
  ];
});
// here need count app project can use like this : projects.mobile.lenght or projects.web.length 
final projectsCountProvider = Provider<Map<String, int>>((ref) {
  final all = ref.watch(allProjectsProvider);
  final mobile = all.where((p) => p.category == 'Mobile').length;
  final web = all.where((p) => p.category == 'Web').length;
  return {'Mobile': mobile, 'Web': web};
});

// Selected category
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

// Filtered projects
final filteredProjectsProvider = Provider<List<UIXProject>>((ref) {
  final selected = ref.watch(selectedCategoryProvider);
  final all = ref.watch(allProjectsProvider);

  if (selected == 'All') return all;
  return all.where((p) => p.category == selected).toList();
});
