// Sample project data
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/domain/models/projects_model.dart';

final allProjectsProvider = Provider<List<UIXProject>>((ref) {
  return [
  UIXProject(
    title: 'Doctor App',
    category: 'Mobile',
    description: 'A Flutter application for doctors to manage their patients and appointments.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/Doctor-App/archive/refs/heads/main.zip',
    tags: ['Flutter', 'Healthcare'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/Doctor-App',
    sourceCodeUrl: 'https://github.com/x-brymo/Doctor-App',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Amazon Responsive UI',
    category: 'Web',
    description: 'A responsive Amazon UI clone built with Flutter.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/Amazon-responsive-ui/archive/refs/heads/main.zip',
    tags: ['Flutter', 'E-commerce'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/Amazon-responsive-ui',
    sourceCodeUrl: 'https://github.com/x-brymo/Amazon-responsive-ui',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'App Finding Phone Number',
    category: 'Mobile',
    description: 'A Python application to find information about phone numbers.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/AppFindingPhoneNumber/archive/refs/heads/main.zip',
    tags: ['Python', 'Utility'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/AppFindingPhoneNumber',
    sourceCodeUrl: 'https://github.com/x-brymo/AppFindingPhoneNumber',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Best Learning Chemistry',
    category: 'Education',
    description: 'An educational project focused on chemistry learning resources.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/Best-Learning-Chemistry/archive/refs/heads/main.zip',
    tags: ['Education', 'Chemistry'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/Best-Learning-Chemistry',
    sourceCodeUrl: 'https://github.com/x-brymo/Best-Learning-Chemistry',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'UI Package',
    category: 'Mobile',
    description: 'A Flutter package providing various UI components.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/ui_package/archive/refs/heads/main.zip',
    tags: ['Flutter', 'UI Components'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/ui_package',
    sourceCodeUrl: 'https://github.com/x-brymo/ui_package',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Profile',
    category: 'Mobile',
    description: 'A Flutter project for user profile management.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/profile/archive/refs/heads/main.zip',
    tags: ['Flutter', 'Profile'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/profile',
    sourceCodeUrl: 'https://github.com/x-brymo/profile',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Equations Balances',
    category: 'Education',
    description: 'A JSON file providing data for reactants and products used in an equation balancer application.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/EquationsBalances/archive/refs/heads/main.zip',
    tags: ['Education', 'Chemistry'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/EquationsBalances',
    sourceCodeUrl: 'https://github.com/x-brymo/EquationsBalances',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Salaty',
    category: 'Mobile',
    description: 'A Flutter application for prayer times and related features.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/salaty/archive/refs/heads/main.zip',
    tags: ['Flutter', 'Religion'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/salaty',
    sourceCodeUrl: 'https://github.com/x-brymo/salaty',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Fast Box',
    category: 'Mobile',
    description: 'A delivery application with three user roles, built with Flutter.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/fast_box/archive/refs/heads/main.zip',
    tags: ['Flutter', 'Delivery'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/fast_box',
    sourceCodeUrl: 'https://github.com/x-brymo/fast_box',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
    title: 'Awesome GitHub Profiles',
    category: 'Web',
    description: 'A curated list of GitHub profiles with awesome customization for inspiration.',
    previewImageUrl: 'https://via.placeholder.com/300',
    downloadUrl: 'https://github.com/x-brymo/awesome-github-profiles/archive/refs/heads/main.zip',
    tags: ['GitHub', 'Profiles'],
    images: [],
    githubUrl: 'https://github.com/x-brymo/awesome-github-profiles',
    sourceCodeUrl: 'https://github.com/x-brymo/awesome-github-profiles',
    demo: null,
    startedAt: null,
    finishedAt: null,
    duration: null,
  ),
  UIXProject(
  title: 'Templates Index',
  category: 'Web',
  description: 'A collection of Flutter and web UI templates categorized by type.',
  previewImageUrl: 'https://via.placeholder.com/300',
  downloadUrl: 'https://github.com/x-brymo/TemplatesIndex/archive/refs/heads/main.zip',
  tags: ['Flutter', 'Templates'],
  images: [],
  githubUrl: 'https://github.com/x-brymo/TemplatesIndex',
  sourceCodeUrl: 'https://github.com/x-brymo/TemplatesIndex',
  demo: null,
  startedAt: null,
  finishedAt: null,
  duration: null,
),
UIXProject(
  title: 'Application Profile',
  category: 'Mobile',
  description: 'Personal profile mobile app using Flutter.',
  previewImageUrl: 'https://via.placeholder.com/300',
  downloadUrl: 'https://github.com/x-brymo/profile/archive/refs/heads/main.zip',
  tags: ['Flutter', 'Profile'],
  images: [],
  githubUrl: 'https://github.com/x-brymo/profile',
  sourceCodeUrl: 'https://github.com/x-brymo/profile',
  demo: null,
  startedAt: null,
  finishedAt: null,
  duration: null,
),
UIXProject(
  title: 'Amazon UI Clone',
  category: 'Web',
  description: 'A responsive clone of Amazon UI using Flutter Web.',
  previewImageUrl: 'https://via.placeholder.com/300',
  downloadUrl: 'https://github.com/x-brymo/Amazon-responsive-ui/archive/refs/heads/main.zip',
  tags: ['Flutter', 'Web', 'E-commerce'],
  images: [],
  githubUrl: 'https://github.com/x-brymo/Amazon-responsive-ui',
  sourceCodeUrl: 'https://github.com/x-brymo/Amazon-responsive-ui',
  demo: null,
  startedAt: null,
  finishedAt: null,
  duration: null,
),
UIXProject(
  title: 'Phone Number Finder',
  category: 'Tool',
  description: 'Python tool to retrieve information about phone numbers.',
  previewImageUrl: 'https://via.placeholder.com/300',
  downloadUrl: 'https://github.com/x-brymo/AppFindingPhoneNumber/archive/refs/heads/main.zip',
  tags: ['Python', 'Tool'],
  images: [],
  githubUrl: 'https://github.com/x-brymo/AppFindingPhoneNumber',
  sourceCodeUrl: 'https://github.com/x-brymo/AppFindingPhoneNumber',
  demo: null,
  startedAt: null,
  finishedAt: null,
  duration: null,
),
UIXProject(
  title: 'Flutter Doctor App',
  category: 'Mobile',
  description: 'An advanced doctor app with multiple features for patient management.',
  previewImageUrl: 'https://via.placeholder.com/300',
  downloadUrl: 'https://github.com/x-brymo/Doctor-App/archive/refs/heads/main.zip',
  tags: ['Flutter', 'Health'],
  images: [],
  githubUrl: 'https://github.com/x-brymo/Doctor-App',
  sourceCodeUrl: 'https://github.com/x-brymo/Doctor-App',
  demo: null,
  startedAt: null,
  finishedAt: null,
  duration: null,
),

  ];
});
// here need count app project can use like this : projects.mobile.lenght or projects.web.length 
final projectsCountProvider = Provider<Map<String, int>>((ref) {
  final all = ref.watch(allProjectsProvider);
  final mobile = all.where((p) => p.category == 'Mobile').length;
  final web = all.where((p) => p.category == 'Web').length;
  final tools = all.where((p) => p.category == 'Tool').length;
  final education = all.where((p) => p.category == 'Education').length;
  final packages = all.where((p) => p.category == 'Packages').length;
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
