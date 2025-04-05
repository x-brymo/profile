import 'package:flutter/material.dart';

import 'core/export.dart';
import 'view/UI/intro/splash_view.dart';
import 'view/UI/update/update_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Builder',
      theme: AppStyle(themeIndex: 0).currentTheme,
      themeAnimationCurve: Curves.easeInOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: UpdateManager(child: SplashView()),
      onGenerateRoute: RouterApp().generateRoute,
      initialRoute: RouterApp.splash,
    );
  }
}



// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final ShorebirdCodePush _shorebirdCodePush = ShorebirdCodePush();
//   bool _isUpdateAvailable = false;
//   bool _isDownloading = false;
//   double _downloadProgress = 0.0;
//   String _updateStatus = "Checking for updates...";
  
//   @override
//   void initState() {
//     super.initState();
//     _checkForUpdates();
//   }
  
//   Future<void> _checkForUpdates() async {
//     try {
//       final isUpdateAvailable = await _shorebirdCodePush.isNewPatchAvailable();
//       setState(() {
//         _isUpdateAvailable = isUpdateAvailable;
//         _updateStatus = isUpdateAvailable 
//             ? "Update available!" 
//             : "Your app is up to date.";
//       });
//     } catch (e) {
//       setState(() {
//         _updateStatus = "Error checking for updates: $e";
//       });
//     }
//   }
  
//   Future<void> _downloadAndInstallUpdate() async {
//     try {
//       setState(() {
//         _isDownloading = true;
//         _downloadProgress = 0.0;
//         _updateStatus = "Downloading update...";
//       });
      
//       await _shorebirdCodePush.downloadUpdateIfAvailable(
//         onProgress: (receivedBytes, totalBytes) {
//           if (totalBytes != null) {
//             setState(() {
//               _downloadProgress = receivedBytes / totalBytes;
//               _updateStatus = "Downloading: ${(_downloadProgress * 100).toStringAsFixed(1)}%";
//             });
//           }
//         },
//       );
      
//       setState(() {
//         _isDownloading = false;
//         _updateStatus = "Update downloaded! Restart to apply.";
//       });
//     } catch (e) {
//       setState(() {
//         _isDownloading = false;
//         _updateStatus = "Error downloading update: $e";
//       });
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.system_update),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => UpdateStatusScreen(
//                     isUpdateAvailable: _isUpdateAvailable,
//                     onCheckForUpdates: _checkForUpdates,
//                     onDownloadUpdate: _downloadAndInstallUpdate,
//                     isDownloading: _isDownloading,
//                     downloadProgress: _downloadProgress,
//                     updateStatus: _updateStatus,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Your App Content Here'),
//             if (_isUpdateAvailable)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.new_releases, color: Colors.blue),
//                             SizedBox(width: 8),
//                             Text(
//                               'Update Available',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Text('A new version of the app is available'),
//                         SizedBox(height: 8),
//                         ElevatedButton(
//                           onPressed: _downloadAndInstallUpdate,
//                           child: Text('Update Now'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             if (_isDownloading)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: LinearProgressIndicator(
//                   value: _downloadProgress,
//                   minHeight: 10,
//                   backgroundColor: Colors.grey[300],
//                   color: Colors.blue,
//                 ),
//               ),
//             if (_updateStatus.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   _updateStatus,
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             if (!_isUpdateAvailable && !_isDownloading)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: _checkForUpdates,
//                   child: Text('Check for Updates'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }