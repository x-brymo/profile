import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My QR', icon: Icon(Icons.qr_code)),
            Tab(text: 'Scan QR', icon: Icon(Icons.qr_code_scanner)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          GenerateQRPage(),
          ScanQRPage(),
        ],
      ),
    );
  }
}

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  final TextEditingController _controller = TextEditingController();
  String _qrData = '';
  QRType _selectedType = QRType.url;
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Generate your QR Code',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SegmentedButton<QRType>(
            segments: const [
              ButtonSegment<QRType>(
                value: QRType.url,
                label: Text('URL'),
                icon: Icon(Icons.link),
              ),
              ButtonSegment<QRType>(
                value: QRType.facebook,
                label: Text('Facebook'),
                icon: Icon(Icons.facebook),
              ),
              ButtonSegment<QRType>(
                value: QRType.twitter,
                label: Text('Twitter'),
                icon: Icon(Icons.send),
              ),
              ButtonSegment<QRType>(
                value: QRType.instagram,
                label: Text('Instagram'),
                icon: Icon(Icons.camera_alt),
              ),
            ],
            selected: {_selectedType},
            onSelectionChanged: (Set<QRType> newSelection) {
              setState(() {
                _selectedType = newSelection.first;
                // Clear the input when changing type
                _controller.clear();
                _qrData = '';
              });
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: _getPlaceholderText(),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  setState(() {
                    _qrData = '';
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String prefix = '';
              switch (_selectedType) {
                case QRType.facebook:
                  prefix = 'https://facebook.com/';
                  break;
                case QRType.twitter:
                  prefix = 'https://twitter.com/';
                  break;
                case QRType.instagram:
                  prefix = 'https://instagram.com/';
                  break;
                case QRType.url:
                  // Ensure URL has http:// or https:// prefix
                  if (_controller.text.isNotEmpty && 
                      !_controller.text.startsWith('http://') && 
                      !_controller.text.startsWith('https://')) {
                    prefix = 'https://';
                  }
                  break;
              }
              
              setState(() {
                _qrData = prefix + _controller.text;
              });
            },
            child: const Text('Generate QR Code'),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Center(
              child: _qrData.isNotEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QrImageView(
                          data: _qrData,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _qrData,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Share QR Code'),
                          onPressed: () {
                            // Add share functionality here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sharing QR code...')),
                            );
                          },
                        ),
                      ],
                    )
                  : const Text('Your QR code will appear here'),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getPlaceholderText() {
    switch (_selectedType) {
      case QRType.url:
        return 'Enter URL';
      case QRType.facebook:
        return 'Enter Facebook username';
      case QRType.twitter:
        return 'Enter Twitter username';
      case QRType.instagram:
        return 'Enter Instagram username';
    }
  }
}

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  MobileScannerController? cameraController;
  bool _isScanning = true;
  String? _scannedCode;
  bool _isTorchOn = false;
  bool _hasPermissionError = false;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
  }
  
  void _initializeScanner() {
    try {
      cameraController = MobileScannerController();
      setState(() {
        _hasPermissionError = false;
      });
    } catch (e) {
      setState(() {
        _hasPermissionError = true;
      });
      print('Error initializing scanner: $e');
    }
  }
  
  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasPermissionError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'Camera permission is required',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Please grant camera permission in your device settings to scan QR codes',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              onPressed: _initializeScanner,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: _isScanning
              ? Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty && _isScanning) {
                          final String code = barcodes.first.rawValue ?? '';
                          debugPrint('Barcode found! $code');
                          setState(() {
                            _scannedCode = code;
                            _isScanning = false;
                          });
                        }
                      },
                      errorBuilder: (context, error, child) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Camera error: ${error.errorCode}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'Please grant camera permission in your device settings',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.refresh),
                                label: const Text('Try Again'),
                                onPressed: () {
                                  setState(() {
                                    _initializeScanner();
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 80,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'QR Code Scanned!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          _scannedCode ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            //color: Colors.white,
            child: Center(
              child: _isScanning
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(_isTorchOn ? Icons.flash_on : Icons.flash_off),
                          onPressed: () {
                            setState(() {
                              _isTorchOn = !_isTorchOn;
                            });
                            if (cameraController != null) {
                              cameraController!.toggleTorch();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Camera controller is not initialized')),
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.flip_camera_ios),
                          onPressed: () => cameraController?.switchCamera(),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('Open'),
                          onPressed: () async {
                            if (_scannedCode != null) {
                              final Uri url = Uri.parse(_scannedCode!);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Could not open this URL')),
                                );
                              }
                            }
                          },
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text('Scan Again'),
                          onPressed: () {
                            setState(() {
                              _isScanning = true;
                              _scannedCode = null;
                            });
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

enum QRType { url, facebook, twitter, instagram }