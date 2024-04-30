import 'package:flutter/material.dart';
import 'package:pantau_pro/dashboard/notifikasi.dart';
import 'package:pantau_pro/dashboard/profil.dart';
import 'package:pantau_pro/dashboard/survey.dart';
import 'package:pantau_pro/register/login.dart';
import 'package:pantau_pro/view/landing.dart';
import 'package:pantau_pro/dashboard/kunjungan.dart';
import 'package:pantau_pro/dashboard/feedback.dart';
import 'package:pantau_pro/dashboard/riwayat.dart';

class HomePage extends StatelessWidget {
  int _selectedIndex = 0;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pantau Tamu Pro',
                  style: TextStyle(fontSize: 24, fontFamily: 'Man'),
                ),
                IconButton(
                  onPressed: () {
                    // Menampilkan Snackbar untuk konfirmasi logout
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Konfirmasi Logout'),
                          content: Text('Apakah Anda yakin ingin keluar?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Logout dan pindahkan ke halaman login
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text('Ya'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                      'Asset/image/background.jpg'), // Change with your image path
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  'Selamat datang di Pantau Tamu Pro!',
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: 'Man'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KunjunganPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const CardWithIcon(
                    imagePath: 'Asset/image/dbform.png',
                    text: 'Buat Kunjungan',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyApp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const CardWithIcon(
                    imagePath: 'Asset/image/survey.png',
                    text: 'Survey Kepuasan',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const CardWithIcon(
                    imagePath: 'Asset/image/feedback.png',
                    text: 'Feedback',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RiwayatApp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const CardWithIcon(
                    imagePath: 'Asset/image/riwayat.png',
                    text: 'Riwayat Pengajuan',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Handle bottom navigation item taps
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            // Navigate to Home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const landingapp()),
            );
          } else if (index == 1) {
            // Navigate to Notifications page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (index == 2) {
            // Navigate to Profile page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void setState(Null Function() param0) {}
}

class CardWithIcon extends StatelessWidget {
  final String imagePath;
  final String text;

  const CardWithIcon({Key? key, required this.imagePath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 80, // Ubah ukuran ikon sesuai keinginan Anda
          height: 80, // Ubah ukuran ikon sesuai keinginan Anda
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
