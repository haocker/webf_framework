import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webf/webf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebF Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WebFPage(),
    );
  }
}

class WebFPage extends StatefulWidget {
  const WebFPage({super.key});

  @override
  State<WebFPage> createState() => _WebFPageState();
}

class _WebFPageState extends State<WebFPage> {
  late WebFController _controller;
  String _currentView = 'file';

  @override
  void initState() {
    super.initState();
    _controller = WebFController();
    _loadHtmlFile();
  }

  Future<void> _loadHtmlFile() async {
    try {
      final htmlContent = await rootBundle.loadString('assets/index.html');
      _controller.loadHTML(htmlContent);
    } catch (e) {
      _controller.loadHTML('''
        <!DOCTYPE html>
        <html>
        <body style="padding: 20px; text-align: center; font-family: Arial;">
          <h2>Error Loading HTML</h2>
          <p>$e</p>
        </body>
        </html>
      ''');
    }
  }

  void _loadInlineHtml() {
    _controller.loadHTML('''
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            font-family: Arial, sans-serif;
            margin: 0;
          }
          .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
          }
          h1 { color: #333; margin-bottom: 20px; }
          .button {
            background: #f093fb;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s;
          }
          .button:hover {
            background: #f5576c;
            transform: translateY(-2px);
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>Inline HTML</h1>
          <p>This HTML is loaded directly from Dart code</p>
          <p>JavaScript is fully supported!</p>
          <button class="button" onclick="alert('Inline HTML works!')">
            Click Me
          </button>
        </div>
      </body>
      </html>
    ''');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebF Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'file',
                label: Text('File'),
                icon: Icon(Icons.description),
              ),
              ButtonSegment(
                value: 'inline',
                label: Text('Inline'),
                icon: Icon(Icons.code),
              ),
            ],
            selected: {_currentView},
            onSelectionChanged: (Set<String> selection) {
              setState(() {
                _currentView = selection.first;
                if (_currentView == 'file') {
                  _loadHtmlFile();
                } else {
                  _loadInlineHtml();
                }
              });
            },
          ),
        ],
      ),
      body: WebFWidget(
        controller: _controller,
      ),
    );
  }
}
