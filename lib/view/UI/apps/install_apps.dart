import 'package:flutter/material.dart';


class AppStoreHomePage extends StatefulWidget {
  const AppStoreHomePage({super.key});

  @override
  _AppStoreHomePageState createState() => _AppStoreHomePageState();
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

class _AppStoreHomePageState extends State<AppStoreHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<App> finishedApps = [];
  List<App> developmentApps = [];
  List<App> releaseApps = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeApps();
  }

  void _initializeApps() {
    // Populate with sample data
    finishedApps = List.generate(
      10,
      (index) => App(
        id: 'fin-${index + 1}',
        name: 'Finished App ${index + 1}',
        imageUrl: 'https://via.placeholder.com/150',
        version: '1.$index',
        rating: 4.0 + (index % 10) / 10,
        size: '${15 + index * 2}MB',
        developer: 'Your Company',
        description: 'This is a completed app ready for use.',
        isInstalled: index < 5, // First 5 are already installed
      ),
    );

    developmentApps = List.generate(
      5,
      (index) => App(
        id: 'dev-${index + 1}',
        name: 'Dev App ${index + 1}',
        imageUrl: 'https://via.placeholder.com/150',
        version: '0.${index + 1}',
        rating: 0.0,
        size: '${10 + index * 3}MB',
        developer: 'Your Company',
        description: 'This app is still in development - ${90 - index * 10}% complete.',
        isInstalled: false,
      ),
    );

    releaseApps = List.generate(
      8,
      (index) => App(
        id: 'rel-${index + 1}',
        name: 'Release App ${index + 1}',
        imageUrl: 'https://via.placeholder.com/150',
        version: '2.$index',
        rating: 3.5 + (index % 5) / 10,
        size: '${20 + index * 4}MB',
        developer: 'Your Company',
        description: 'This app is ready for release and installation.',
        isInstalled: index < 2, // First 2 are already installed
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _installApp(App app) {
    setState(() {
      app.isInstalling = true;
      app.downloadProgress = 0.0;
    });

    // Simulate download and installation process
    Future.delayed(const Duration(milliseconds: 500), () {
      _simulateDownload(app);
    });
  }

  void _simulateDownload(App app) {
    if (app.downloadProgress < 1.0) {
      setState(() {
        app.downloadProgress += 0.1;
      });
      
      Future.delayed(const Duration(milliseconds: 500), () {
        _simulateDownload(app);
      });
    } else {
      setState(() {
        app.isInstalling = false;
        app.isInstalled = true;
        app.downloadProgress = 0.0;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${app.name} installed successfully')),
      );
    }
  }

  void _uninstallApp(App app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Uninstall ${app.name}'),
        content: Text('Are you sure you want to uninstall ${app.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                app.isInstalled = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${app.name} uninstalled')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Uninstall'),
          ),
        ],
      ),
    );
  }

  void _openAppDetails(App app) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppDetailsPage(
          app: app,
          onInstall: () => _installApp(app),
          onUninstall: () => _uninstallApp(app),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Store Profile'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Finished Apps'),
            Tab(text: 'Development'),
            Tab(text: 'Release'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFinishedAppsTab(),
          _buildDevelopmentTab(),
          _buildReleaseTab(),
        ],
      ),
    );
  }

  Widget _buildFinishedAppsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: finishedApps.length,
      itemBuilder: (context, index) {
        final app = finishedApps[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(app.imageUrl),
            ),
            title: Text(app.name),
            subtitle: Text('Version ${app.version}'),
            trailing: app.isInstalling
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : app.isInstalled
                    ? IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _uninstallApp(app),
                      )
                    : IconButton(
                        icon: const Icon(Icons.download, color: Colors.blue),
                        onPressed: () => _installApp(app),
                      ),
            onTap: () => _openAppDetails(app),
          ),
        );
      },
    );
  }

  Widget _buildDevelopmentTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: developmentApps.length,
      itemBuilder: (context, index) {
        final app = developmentApps[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: const Icon(Icons.code, color: Colors.white),
                ),
                title: Text(app.name),
                subtitle: Text(app.description),
                trailing: const Icon(Icons.edit),
                onTap: () => _openAppDetails(app),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: LinearProgressIndicator(
                  value: double.parse(app.description.split('%')[0].split(' - ')[1]) / 100,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReleaseTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: releaseApps.length,
      itemBuilder: (context, index) {
        final app = releaseApps[index];
        return _buildAppCard(app: app);
      },
    );
  }

  Widget _buildAppCard({required App app}) {
    return GestureDetector(
      onTap: () => _openAppDetails(app),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                app.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App title
                  Text(
                    app.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // App rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        ' ${app.rating.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Text(app.size, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Install button or progress
                  if (app.isInstalling)
                    Column(
                      children: [
                        LinearProgressIndicator(value: app.downloadProgress),
                        const SizedBox(height: 4),
                        Text(
                          '${(app.downloadProgress * 100).toInt()}%',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: app.isInstalled ? () => _uninstallApp(app) : () => _installApp(app),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: app.isInstalled ? Colors.red : Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(app.isInstalled ? 'Uninstall' : 'Install'),
                      ),
                    ),
                ],
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