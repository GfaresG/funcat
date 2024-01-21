import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  final Uri uri = Uri.parse('https://example.com/whatsit/create');
  final http.Response response = await http.post(
    uri,
    body: {'name': 'dooble', 'color': 'blue'},
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  runApp(
    MaterialApp(
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String statusCodeee = '';
  var controller = TextEditingController();

  checkStatusCode() async {
    try {
      final uri = await http.get(Uri.parse('https://' + controller.text));
      setState(() {
        statusCodeee = uri.statusCode.toString();
      });
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid URL")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fun Cat"),
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      controller: controller,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: checkStatusCode,
                  icon: const Icon(Icons.search_sharp),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 2),
                child: statusCodeee.isEmpty
                    ? Container(
                  child: const Text('Type a URL'),
                )
                    : Image.network('https://http.cat/$statusCodeee',width: 500,height: 600,fit:BoxFit.fill,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
