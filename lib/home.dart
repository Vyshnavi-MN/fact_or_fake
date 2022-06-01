// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:pdf_text/pdf_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //   );
  // }
  // PDFDoc? _pdfDoc;
  // String _text = "";

  // bool _buttonsEnabled = true;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //         appBar: AppBar(
  //           title: const Text("Let's Summarize and Find out the facts"),
  //         ),
  //         body: Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(10),
  //           child: ListView(
  //             children: <Widget>[
  //               TextButton(
  //                 style: TextButton.styleFrom(
  //                     padding: const EdgeInsets.all(5),
  //                     backgroundColor: Colors.blueAccent),
  //                 onPressed: _pickPDFText,
  //                 child: const Text(
  //                   "Pick PDF document",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(15),
  //                 child: Text(
  //                   _pdfDoc == null
  //                       ? "Pick a new PDF document and wait for it to load..."
  //                       : "PDF document loaded, ${_pdfDoc!.length} pages\n",
  //                   style: const TextStyle(fontSize: 18),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               TextButton(
  //                 style: TextButton.styleFrom(
  //                     padding: const EdgeInsets.all(5),
  //                     backgroundColor: Colors.blueAccent),
  //                 onPressed: _buttonsEnabled ? _readWholeDoc : () {},
  //                 child: const Text(
  //                   "Summarize the document",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(15),
  //                 child: Text(
  //                   _text == "" ? "" : "Text:",
  //                   style: const TextStyle(fontSize: 18),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Text(_text),
  //             ],
  //           ),
  //         )),
  //   );
  // }

  // /// Picks a new PDF document from the device
  // Future _pickPDFText() async {
  //   var filePickerResult = await FilePicker.platform.pickFiles();
  //   if (filePickerResult != null) {
  //     _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
  //     setState(() {});
  //   }
  // }

  // /// Reads the whole document
  // Future _readWholeDoc() async {
  //   if (_pdfDoc == null) {
  //     return;
  //   }
  //   setState(() {
  //     _buttonsEnabled = false;
  //   });

  //   String text = await _pdfDoc!.text;

  //   var url = Uri.parse('https://api.oneai.com/api/v0/pipeline');

  //   var headers = {
  //     'accept': 'application/json',
  //     'Content-Type': 'application/json-patch+json',
  //     'api-key': '97fd8472-2d93-407a-8412-8687b7d5ab83'
  //   };

  //   var body = json.encode({
  //     'input': text,
  //     'input_type': 'article',
  //     'steps': [
  //       {'skill': 'summarize'}
  //     ]
  //   });

  //   var response = await http.post(url, headers: headers, body: body);

  //   if (response.statusCode != 200) {
  //     throw Exception('http.post error: statusCode= ${response.statusCode}');
  //   }

  //   var result = json.decode(response.body);
  //   print(result['output'][0]['text']);
  //   setState(() {
  //     _text = result['output'][0]['text'];
  //     _buttonsEnabled = true;
  //   });
  // }
  String _text = "output";
  bool _true = true;
  late TextEditingController _c;
  @override
  initState() {
    _c = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Let's find out the truth"),
            backgroundColor: Colors.amber,
          ),
          body: Center(
              child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(25),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Text',
                  ),
                  controller: _c,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () async {
                  var url = Uri.parse('https://api.oneai.com/api/v0/pipeline');
                  var body = jsonEncode({
                    "input": "$_c.text",
                    "input_type": "article",
                    "steps": [
                      {"skill": "summarize"}
                    ]
                  });
                  var response = await http.post(
                    url,
                    headers: {
                      'accept': 'application/json',
                      'Content-Type': 'application/json-patch+json',
                      'api-key': '97fd8472-2d93-407a-8412-8687b7d5ab83'
                    },
                    body: body,
                  );
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                  var result = json.decode(response.body);

                  url = Uri.parse(
                      "https://dawg-fake-news-detector.p.rapidapi.com/predict");
                  body = "text=$_c.text";
                  response = await http.post(
                    url,
                    headers: {
                      "content-type": "application/x-www-form-urlencoded",
                      "X-RapidAPI-Host":
                          "dawg-fake-news-detector.p.rapidapi.com",
                      "X-RapidAPI-Key":
                          "eccd261783msh467010ec9c188ddp12249ajsn99e8214906ff"
                    },
                    body: body,
                  );
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                  var result2 = json.decode(response.body);

                  setState(() {
                    _text = result['output'][0]['text'];
                    print(result['output'][0]['text']);

                    _true = result2['prediction'];
                    print(result2['prediction']);
                  });
                },
                child: const Text(
                  'SUMMARIZE',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(_text),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(_true.toString()),
              ),
            )
          ]))),
    );
  }
}
