import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pantau_pro/register/Home_page.dart';

void main() {
  runApp(MaterialApp(
    home: FeedbackPage(),
  ));
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _selectedIndex = 0;
  final TextEditingController _messageController = TextEditingController();

  Future<void> sendFeedback() async {
    var url = Uri.parse(
        'http://localhost:8000/api/feedback_flutter'); // Sesuaikan URL dengan endpoint Anda
    var body = jsonEncode({
      'keterangan': _messageController.text,
    });

    try {
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        print('Feedback terkirim!');
        _showFeedbackSentSnackbar(context);
      } else {
        print('Gagal mengirim feedback. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  void _showFeedbackSentSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback telah terkirim!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Feedback'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Berikan Masukan Anda',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Pesan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: sendFeedback,
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0) {
              // Navigate to homepage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (index == 1) {
              // Show Popup Menu
              _showMenu(context);
            } else if (index == 2) {
              // Navigate to Edit Profile page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const EditProfilePage(),
              //   ),
              // );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rocket_launch), // Use a unique icon here
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        0,
        MediaQuery.of(context).size.height,
        0,
        0,
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Buat Kunjungan'),
            onTap: () {
              // Navigate to Buat Kunjungan page
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Riwayat kunjungan'),
            onTap: () {
              // Navigate to Riwayat kunjungan page
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.business),
            title: Text('Struktur Organisasi'),
            onTap: () {
              // Navigate to Struktur Organisasi page
            },
          ),
        ),
        // Add more menu items here
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackPage(),
                ),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Survey'),
            onTap: () {
              // Navigate to Survey page
            },
          ),
        ),
        PopupMenuItem(
          child: ExpansionTile(
            leading: Icon(Icons.settings),
            title: Text('Pengaturan'),
            children: <Widget>[
              ListTile(
                title: Text('Edit Profil'),
                onTap: () {
                  // Navigate to Edit Profile page
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi'),
                        content: Text('Apakah Anda yakin untuk keluar?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Tidak'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                          ),
                          TextButton(
                            child: Text('Ya'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              // Navigate to Login page
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.help),
            title: Text('Bantuan'),
            onTap: () {
              // Action when Help is tapped
            },
          ),
        ),
      ],
    );
  }
}
