import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class Package {
  final String id;
  final String name;
  final String description;
  final String version;
  final String packageManager; // npm, pub.dev, pip, etc.
  final String packageUrl;
  final String? githubUrl;
  final int stars;
  final int downloads;
  final String lastUpdated;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.packageManager,
    required this.packageUrl,
    this.githubUrl,
    required this.stars,
    required this.downloads,
    required this.lastUpdated,
  });
}

class PackageManagerScreen extends StatefulWidget {
  const PackageManagerScreen({super.key});

  @override
  _PackageManagerScreenState createState() => _PackageManagerScreenState();
}

class _PackageManagerScreenState extends State<PackageManagerScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Package> _allPackages = [];
  Map<String, List<Package>> _packagesByManager = {};
  List<String> _packageManagers = [];

  @override
  void initState() {
    super.initState();
    _initializePackages();
    _organizePackagesByManager();
    _tabController = TabController(length: _packageManagers.length, vsync: this);
  }

  void _initializePackages() {
    // Sample packages - replace with your actual packages
    _allPackages.addAll([
      // npm packages
      Package(
        id: 'react',
        name: 'react',
        description: 'A JavaScript library for building user interfaces',
        version: '18.2.0',
        packageManager: 'npm',
        packageUrl: 'https://www.npmjs.com/package/react',
        githubUrl: 'https://github.com/facebook/react',
        stars: 196000,
        downloads: 24500000,
        lastUpdated: '2023-03-15',
      ),
      Package(
        id: 'lodash',
        name: 'lodash',
        description: 'A modern JavaScript utility library delivering modularity, performance & extras',
        version: '4.17.21',
        packageManager: 'npm',
        packageUrl: 'https://www.npmjs.com/package/lodash',
        githubUrl: 'https://github.com/lodash/lodash',
        stars: 54000,
        downloads: 38200000,
        lastUpdated: '2022-08-10',
      ),
      
      // pub.dev packages
      Package(
        id: 'flutter_bloc',
        name: 'flutter_bloc',
        description: 'Flutter Widgets that make it easy to implement the BLoC design pattern',
        version: '8.1.2',
        packageManager: 'pub.dev',
        packageUrl: 'https://pub.dev/packages/flutter_bloc',
        githubUrl: 'https://github.com/felangel/bloc',
        stars: 8300,
        downloads: 986000,
        lastUpdated: '2023-02-22',
      ),
      Package(
        id: 'provider',
        name: 'provider',
        description: 'A wrapper around InheritedWidget to make them easier to use and more reusable',
        version: '6.0.5',
        packageManager: 'pub.dev',
        packageUrl: 'https://pub.dev/packages/provider',
        githubUrl: 'https://github.com/rrousselGit/provider',
        stars: 5200,
        downloads: 2750000,
        lastUpdated: '2022-12-15',
      ),
      
      // pip packages
      Package(
        id: 'requests',
        name: 'requests',
        description: 'Python HTTP for Humans',
        version: '2.28.2',
        packageManager: 'pip',
        packageUrl: 'https://pypi.org/project/requests/',
        githubUrl: 'https://github.com/psf/requests',
        stars: 48500,
        downloads: 78900000,
        lastUpdated: '2023-01-05',
      ),
      Package(
        id: 'pandas',
        name: 'pandas',
        description: 'Powerful data structures for data analysis, time series, and statistics',
        version: '1.5.3',
        packageManager: 'pip',
        packageUrl: 'https://pypi.org/project/pandas/',
        githubUrl: 'https://github.com/pandas-dev/pandas',
        stars: 38000,
        downloads: 45600000,
        lastUpdated: '2023-02-10',
      ),
    ]);
  }

  void _organizePackagesByManager() {
    _packagesByManager = {};
    
    for (var package in _allPackages) {
      if (!_packagesByManager.containsKey(package.packageManager)) {
        _packagesByManager[package.packageManager] = [];
      }
      _packagesByManager[package.packageManager]!.add(package);
    }
    
    _packageManagers = _packagesByManager.keys.toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Packages'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _packageManagers.map((manager) => Tab(text: manager)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _packageManagers.map((manager) {
          return _buildPackageList(_packagesByManager[manager]!);
        }).toList(),
      ),
    );
  }

  Widget _buildPackageList(List<Package> packages) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          child: InkWell(
            onTap: () => _showPackageDetails(package),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Package logo/icon - using placeholder based on package manager
                      _buildPackageIcon(package.packageManager),
                      const SizedBox(width: 12),
                      // Package name and version
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'v${package.version}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // External links
                      Row(
                        children: [
                          IconButton(
                            icon: _buildManagerIcon(package.packageManager),
                            onPressed: () => _launchUrl(package.packageUrl),
                            tooltip: 'View on ${package.packageManager}',
                          ),
                          if (package.githubUrl != null)
                            IconButton(
                              icon: const Icon(Icons.code, color: Colors.black87),
                              onPressed: () => _launchUrl(package.githubUrl!),
                              tooltip: 'View source on GitHub',
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Package description
                  Text(
                    package.description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Package stats
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber[700]),
                      const SizedBox(width: 4),
                      Text(_formatNumber(package.stars)),
                      const SizedBox(width: 16),
                      Icon(Icons.download, size: 16, color: Colors.blue[700]),
                      const SizedBox(width: 4),
                      Text(_formatNumber(package.downloads)),
                      const SizedBox(width: 16),
                      Icon(Icons.update, size: 16, color: Colors.green[700]),
                      const SizedBox(width: 4),
                      Text('Updated: ${package.lastUpdated}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPackageIcon(String packageManager) {
    Color backgroundColor;
    IconData iconData;
    
    switch (packageManager) {
      case 'npm':
        backgroundColor = Colors.red;
        iconData = Icons.code;
        break;
      case 'pub.dev':
        backgroundColor = Colors.blue;
        iconData = FontAwesomeIcons.dartLang;
        break;
      case 'pip':
        backgroundColor = Colors.green;
        iconData = Icons.data_object;
        break;
      default:
        backgroundColor = Colors.grey;
        iconData = Icons.extension;
    }
    
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Icon(iconData, color: Colors.white),
    );
  }

  Widget _buildManagerIcon(String packageManager) {
    switch (packageManager) {
      case 'npm':
        return const Icon(FontAwesomeIcons.js, color: Colors.red);
      case 'pub.dev':
        return const Icon(FontAwesomeIcons.dartLang, color: Colors.blue);
      case 'pip':
        return const Icon(FontAwesomeIcons.python, color: Colors.green);
      default:
        return const Icon(Icons.extension, color: Colors.grey);
    }
  }

  void _showPackageDetails(Package package) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package header
                  Row(
                    children: [
                      _buildPackageIcon(package.packageManager),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Version ${package.version}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Links
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: _buildManagerIcon(package.packageManager),
                          label: Text('View on ${package.packageManager}'),
                          onPressed: () => _launchUrl(package.packageUrl),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (package.githubUrl != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.code),
                            label: const Text('Source Code'),
                            onPressed: () => _launchUrl(package.githubUrl!),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  
                  // Stats
                  const Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildStatRow(Icons.star, Colors.amber, 'Stars', _formatNumber(package.stars)),
                  _buildStatRow(Icons.download, Colors.blue, 'Downloads', _formatNumber(package.downloads)),
                  _buildStatRow(Icons.update, Colors.green, 'Last Updated', package.lastUpdated),
                  const SizedBox(height: 24),
                  
                  // Install command
                  const Text(
                    'Installation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                     // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getInstallCommand(package),
                            style: const TextStyle(
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            // In a real app, use clipboard functionality
                            Clipboard.setData(ClipboardData(text: _getInstallCommand(package)));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Copied to clipboard')),
                            );
                          },
                          tooltip: 'Copy to clipboard',
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            Share.share(_getInstallCommand(package));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Shared successfully')),
                            );
                          },
                          tooltip: 'Share',
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatRow(IconData icon, Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  String _getInstallCommand(Package package) {
    switch (package.packageManager) {
      case 'npm':
        return 'npm install ${package.name}';
      case 'pub.dev':
        return 'flutter pub add ${package.name}';
      case 'pip':
        return 'pip install ${package.name}';
      default:
        return 'Install ${package.name}';
    }
  }
}