import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Package {
  final String name;
  final String type; // npm, pub.dev, pip, etc.
  final String description;
  final String packageUrl;
  final String? githubUrl;
  final String iconUrl;
  final String? version;
  final int? stars;
  final int? downloads;

  Package({
    required this.name,
    required this.type,
    required this.description,
    required this.packageUrl,
    this.githubUrl,
    required this.iconUrl,
    this.version,
    this.stars,
    this.downloads,
  });
}

class MangerCLI extends StatefulWidget {
  const MangerCLI({super.key});

  @override
  _MangerCLIState createState() => _MangerCLIState();
}

class _MangerCLIState extends State<MangerCLI> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> packageTypes = ['All', 'npm', 'pub.dev', 'pip', 'gem', 'composer'];
  List<Package> allPackages = [];
  List<Package> filteredPackages = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: packageTypes.length, vsync: this);
    _tabController.addListener(_handleTabChange);
    
    // Use Future.microtask to initialize packages after the widget is built
    Future.microtask(() {
      _initializePackages();
      setState(() {
        filteredPackages = List.from(allPackages);
        isLoading = false;
      });
    });
  }

  void _initializePackages() {
    // Sample data - replace with your actual plugins and CLI tools
    allPackages = [
      Package(
        name: 'react-native-awesome-ui',
        type: 'npm',
        description: 'A collection of beautiful UI components for React Native applications',
        packageUrl: 'https://www.npmjs.com/package/react-native-awesome-ui',
        githubUrl: 'https://github.com/yourusername/react-native-awesome-ui',
        iconUrl: 'https://raw.githubusercontent.com/npm/logos/master/npm%20logo/npm-logo-red.png',
        version: '2.3.1',
        stars: 245,
        downloads: 12500,
      ),
      Package(
        name: 'flutter_responsive_layout',
        type: 'pub.dev',
        description: 'Create responsive layouts easily in Flutter',
        packageUrl: 'https://pub.dev/packages/flutter_responsive_layout',
        githubUrl: 'https://github.com/yourusername/flutter_responsive_layout',
        iconUrl: 'https://pub.dev/static/img/pub-dev-logo.svg',
        version: '1.2.0',
        stars: 187,
        downloads: 8760,
      ),
      Package(
        name: 'data-visualizer',
        type: 'pip',
        description: 'A Python package for creating interactive data visualizations',
        packageUrl: 'https://pypi.org/project/data-visualizer',
        githubUrl: 'https://github.com/yourusername/data-visualizer',
        iconUrl: 'https://pypi.org/static/images/logo-small.2a1fc5cf.svg',
        version: '0.9.4',
        stars: 124,
        downloads: 5430,
      ),
      Package(
        name: 'cli-tools',
        type: 'npm',
        description: 'A set of CLI tools for automating development workflows',
        packageUrl: 'https://www.npmjs.com/package/cli-tools',
        githubUrl: 'https://github.com/yourusername/cli-tools',
        iconUrl: 'https://raw.githubusercontent.com/npm/logos/master/npm%20logo/npm-logo-red.png',
        version: '3.1.2',
        stars: 310,
        downloads: 24800,
      ),
      Package(
        name: 'ruby-data-parser',
        type: 'gem',
        description: 'A Ruby gem for parsing and processing complex data formats',
        packageUrl: 'https://rubygems.org/gems/ruby-data-parser',
        githubUrl: 'https://github.com/yourusername/ruby-data-parser',
        iconUrl: 'https://rubygems.org/favicon.ico',
        version: '1.0.3',
        stars: 89,
        downloads: 3250,
      ),
      Package(
        name: 'laravel-easy-api',
        type: 'composer',
        description: 'Simplified API creation for Laravel applications',
        packageUrl: 'https://packagist.org/packages/yourusername/laravel-easy-api',
        githubUrl: 'https://github.com/yourusername/laravel-easy-api',
        iconUrl: 'https://getcomposer.org/img/logo-composer-transparent.png',
        version: '2.1.0',
        stars: 156,
        downloads: 7890,
      ),
      Package(
        name: 'ml-toolkit',
        type: 'pip',
        description: 'Machine learning utilities for data scientists',
        packageUrl: 'https://pypi.org/project/ml-toolkit',
        githubUrl: 'https://github.com/yourusername/ml-toolkit',
        iconUrl: 'https://pypi.org/static/images/logo-small.2a1fc5cf.svg',
        version: '1.4.2',
        stars: 278,
        downloads: 18700,
      ),
      Package(
        name: 'state-management',
        type: 'pub.dev',
        description: 'Simplified state management for Flutter applications',
        packageUrl: 'https://pub.dev/packages/state_management',
        githubUrl: 'https://github.com/yourusername/state_management',
        iconUrl: 'https://pub.dev/static/img/pub-dev-logo.svg',
        version: '2.0.1',
        stars: 412,
        downloads: 32450,
      ),
    ];
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _filterPackages();
    }
  }

  void _filterPackages() {
    setState(() {
      String selectedType = packageTypes[_tabController.index];
      
      if (selectedType == 'All') {
        filteredPackages = allPackages.where((package) => 
          package.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          package.description.toLowerCase().contains(searchQuery.toLowerCase())
        ).toList();
      } else {
        filteredPackages = allPackages.where((package) => 
          package.type == selectedType &&
          (package.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          package.description.toLowerCase().contains(searchQuery.toLowerCase()))
        ).toList();
      }
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      _filterPackages();
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plugins & CLI Tools'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: packageTypes.map((type) => Tab(text: type)).toList(),
        ),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: _updateSearchQuery,
                  decoration: InputDecoration(
                    hintText: 'Search packages...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(packageTypes.length, (tabIndex) {
                    final tabFilteredPackages = packageTypes[tabIndex] == 'All'
                        ? allPackages.where((package) =>
                            package.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                            package.description.toLowerCase().contains(searchQuery.toLowerCase())).toList()
                        : allPackages.where((package) =>
                            package.type == packageTypes[tabIndex] &&
                            (package.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                            package.description.toLowerCase().contains(searchQuery.toLowerCase()))).toList();

                    return tabFilteredPackages.isEmpty
                        ? const Center(child: Text('No packages found'))
                        : ListView.builder(
                            itemCount: tabFilteredPackages.length,
                            itemBuilder: (context, index) {
                              final package = tabFilteredPackages[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          package.iconUrl,
                                          width: 40,
                                          height: 40,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 40,
                                              height: 40,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.extension),
                                            );
                                          },
                                        ),
                                      ),
                                      title: Text(
                                        package.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(package.description),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade100,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  package.type,
                                                  style: TextStyle(fontSize: 12, color: Colors.blue.shade800),
                                                ),
                                              ),
                                              if (package.version != null) ...[
                                                const SizedBox(width: 8),
                                                Text(
                                                  'v${package.version}',
                                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.link),
                                            tooltip: 'Open package page',
                                            onPressed: () => _launchUrl(package.packageUrl),
                                          ),
                                          if (package.githubUrl != null)
                                            IconButton(
                                              icon: const Icon(Icons.code),
                                              tooltip: 'View source code',
                                              onPressed: () => _launchUrl(package.githubUrl!),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (package.stars != null || package.downloads != null)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                        child: Row(
                                          children: [
                                            if (package.stars != null) ...[
                                              const Icon(Icons.star, size: 16, color: Colors.amber),
                                              const SizedBox(width: 4),
                                              Text(
                                                package.stars.toString(),
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(width: 16),
                                            ],
                                            if (package.downloads != null) ...[
                                              const Icon(Icons.download, size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${package.downloads!.toString()} downloads',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                  }),
                ),
              ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new package functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new package feature coming soon')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}