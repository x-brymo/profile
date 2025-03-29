import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/dart.dart';
import 'package:share_plus/share_plus.dart';
// Import flutter_eval properly based on their documentation
import 'package:flutter_eval/flutter_eval.dart';

class CodeEditorScreen extends StatefulWidget {
  const CodeEditorScreen({super.key});

  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  late CodeController _codeController;
  Widget? _previewWidget;
  bool _hasError = false;
  String _errorMessage = '';

  // Flutter widget template code
  String defaultCode = '''
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 100,
      width: 100,
      child: const Center(
        child: Text(
          "Hello World!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
''';

  @override
  void initState() {
    super.initState();
    // Initialize the code controller with proper Dart language syntax
    _codeController = CodeController(
      text: defaultCode,
      language: dart,
      stringMap: monokaiSublimeTheme,
      patternMap: {
        'keyword': const TextStyle(color: Color(0xfff92672)),
        'string': const TextStyle(color: Color(0xffe6db74)),
        'comment': const TextStyle(color: Color(0xff75715e)),
      },
      
    );
    
    // Add a listener to the controller to update the preview
    _codeController.addListener(() {
      _updatePreview();
    });
    
    // Initialize preview
    _updatePreview();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Code copied to clipboard!")),
    );
  }

  void _shareCode() {
    Share.share(_codeController.text);
  }

  void _resetCode() {
    setState(() {
      _codeController.text = defaultCode;
    });
  }

  void _updatePreview() {
    try {
      // This is a placeholder for the flutter_eval implementation
      // In a real implementation, you would use the flutter_eval package
      // to evaluate the code and generate a widget
      
      // For demonstration, we'll parse the code to check for basic syntax errors
      if (_codeController.text.contains('build(BuildContext context)') &&
          _codeController.text.contains('return')) {
        setState(() {
          _hasError = false;
          // In a real implementation, this would be the actual widget
          _previewWidget = Container(
            color: Colors.blue,
            height: 100,
            width: 100,
            child: const Center(
              child: Text(
                "Preview Widget",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
      } else {
        setState(() {
          _hasError = true;
          _errorMessage = "Code must contain a valid build method with a return statement";
          _previewWidget = null;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _previewWidget = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Code Editor"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.code), text: "Editor"),
              Tab(icon: Icon(Icons.preview), text: "Preview"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: "Reset Code",
              onPressed: _resetCode,
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: "Copy Code",
              onPressed: _copyCode,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: "Share Code",
              onPressed: _shareCode,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Editor Tab
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CodeField(
                controller: _codeController,
                textStyle: const TextStyle(fontFamily: 'SourceCode'),
                lineNumberStyle: LineNumberStyle(
                  width: 60, 
                  textStyle: const TextStyle(color: Colors.grey),
                ),
                expands: true,
              ),
            ),
            
            // Preview Tab
            Center(
              child: _hasError
                  ? Text(
                      "Error: $_errorMessage",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    )
                  : _previewWidget ?? const CircularProgressIndicator(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _updatePreview,
          tooltip: 'Update Preview',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

// Add this to your main.dart to use the editor
/*
void main() {
  runApp(MaterialApp(
    title: 'Flutter Code Editor',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Roboto',
    ),
    home: const CodeEditorScreen(),
  ));
}
*/