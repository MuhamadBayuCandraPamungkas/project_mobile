import 'package:flutter/material.dart';
import 'package:pantau_pro/register/login.dart';

void main() {
  runApp(LandingPage());
}

class landingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'Asset/image/background.jpg'), // Ganti dengan gambar latar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0), // Jarak antara kiri dan kanan pada layar
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to MyApp',
                    textAlign:
                        TextAlign.center, // Membuat teks menjadi di tengah
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Opacity(
                    opacity: 0.7, // Menurunkan opasitas teks
                    child: Text(
                      'Dengan Pantau Tamu Pro, Anda dapat melacak kedatangan tamu, memahami preferensi mereka, dan memberikan layanan yang disesuaikan. Jadikan setiap kunjungan tak terlupakan.',
                      textAlign:
                          TextAlign.center, // Membuat teks menjadi di tengah
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to another screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginApp(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .white, // Mengubah warna background tombol menjadi putih
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255,
                            255), // Mengubah warna teks menjadi biru
                      ),
                    ),
                    child: Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
