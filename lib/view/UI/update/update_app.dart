import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:shorebird_code_push/src/shorebird_updater.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class UpdateManager extends StatefulWidget {
  final Widget child;
  
  const UpdateManager({super.key, required this.child});

  @override
  _UpdateManagerState createState() => _UpdateManagerState();
}

class _UpdateManagerState extends State<UpdateManager> {
  final ShorebirdUpdater _updater = ShorebirdUpdater();
   final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isUpdateAvailable = false;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String _updateStatus = "Checking for updates...";
  
  @override
  void initState() {
    super.initState();
    _checkForUpdates();
    _initializeNotifications();
  }
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }
  
  Future<void> _checkForUpdates() async {
    try {
      final status = await _updater.checkForUpdate();
      setState(() {
        _isUpdateAvailable = status == UpdateStatus.outdated;
        _updateStatus = _isUpdateAvailable ? "Update available!" : "Your app is up to date.";
      });
      
      if (_isUpdateAvailable) {
        _showUpdateAvailableNotification();
      }
    } catch (e) {
      setState(() {
        _updateStatus = "Error checking for updates: $e";
      });
    }
  }
  
  Future<void> _downloadAndInstallUpdate() async {
    try {
      setState(() {
        _isDownloading = true;
        _downloadProgress = 0.0;
        _updateStatus = "Downloading update...";
      });
      
      await _updater.update();
      
      setState(() {
        _isDownloading = false;
        _updateStatus = "Update downloaded! Restart to apply.";
      });
      
      _showRestartDialog();
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _updateStatus = "Error downloading update: $e";
      });
    }
  }
  
  void _showUpdateAvailableNotification() {
    _notificationsPlugin.show(
      0,
      'Update Available',
      'A new update is available. Open the app to update!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'update_channel',
          'App Updates',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('A new update is available!'),
        action: SnackBarAction(
          label: 'Update Now',
          onPressed: _showUpdateDialog,
        ),
        duration: Duration(seconds: 8),
      ),
    );
  }
  
  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text('Would you like to download the update now?'),
          actions: [
            TextButton(
              child: Text('Later'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Update Now'),
              onPressed: () {
                Navigator.of(context).pop();
                _downloadAndInstallUpdate();
              },
            ),
          ],
        );
      },
    );
  }
  
  void _showRestartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Ready'),
          content: Text('The update has been downloaded. Please restart the app to apply the changes.'),
          actions: [
            TextButton(
              child: Text('Later'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Restart Now'),
              onPressed: () {
                Navigator.of(context).pop();
                _restartApp();
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<void> _restartApp() async {
    await _updater.update();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButton: _isUpdateAvailable 
        ? FloatingActionButton(
            onPressed: _showUpdateDialog,
            tooltip: 'Update available',
            child: Icon(Icons.system_update),
          ) 
        : null,
    );
  }
}
