import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pantau_pro/register/Home_page.dart';

void main() {
  runApp(SurveyApp());
}

class SurveyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<dynamic>? questions;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    print('Fetching questions...');
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/questions_flutter'));
    if (response.statusCode == 200) {
      print('Questions fetched successfully.');
      setState(() {
        questions = json.decode(response.body);
        questions!.forEach((question) {
          question['answer'] =
              null; // Initialize answer field for each question
        });
      });
      print('Questions: $questions');
    } else {
      print('Failed to load questions. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load questions');
    }
  }

  Future<void> sendDataToBackend() async {
    if (questions == null) return;

    List<Map<String, dynamic>> answers = questions!.map((question) {
      return {
        'question': question['questions'],
        'answer': question['answer'],
      };
    }).toList();

    // Log the data being sent
    print('Sending data to backend: ${json.encode(answers)}');

    final url = Uri.parse('http://localhost:8000/api/survey_flutter');
    final response = await http.post(
      url,
      body: json.encode(answers),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Data sent successfully!');
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Survey Terikirim, Terimakasih'),
        ),
      );
    } else {
      print('Failed to send data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Survey Form'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (questions == null)
                Center(child: CircularProgressIndicator())
              else
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: questions!.map<Widget>((question) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question['questions'],
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Column(
                              children: [
                                RadioListTile<String>(
                                  title: const Text('Baik'),
                                  value: 'Baik',
                                  groupValue: question['answer'],
                                  onChanged: (value) {
                                    setState(() {
                                      question['answer'] = value!;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Sangat Baik'),
                                  value: 'Sangat Baik',
                                  groupValue: question['answer'],
                                  onChanged: (value) {
                                    setState(() {
                                      question['answer'] = value!;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Buruk'),
                                  value: 'Buruk',
                                  groupValue: question['answer'],
                                  onChanged: (value) {
                                    setState(() {
                                      question['answer'] = value!;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Sangat Buruk'),
                                  value: 'Sangat Buruk',
                                  groupValue: question['answer'],
                                  onChanged: (value) {
                                    setState(() {
                                      question['answer'] = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await sendDataToBackend();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit Survey',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
