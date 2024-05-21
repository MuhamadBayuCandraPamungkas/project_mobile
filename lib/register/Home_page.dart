import 'package:flutter/material.dart';
import 'package:pantau_pro/dashboard/notifikasi.dart';
import 'package:pantau_pro/dashboard/profil.dart';
import 'package:pantau_pro/dashboard/survey.dart';
import 'package:pantau_pro/menu.dart/struktur.dart';
import 'package:pantau_pro/register/login.dart';
import 'package:pantau_pro/dashboard/kunjungan.dart';
import 'package:pantau_pro/dashboard/feedback.dart';
import 'package:pantau_pro/dashboard/riwayat.dart';
import 'package:pantau_pro/view/pageview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Riwayat kunjungan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RiwayatApp(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Struktur Organisasi'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StrukturPage(),
                  ),
                );
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              children: <Widget>[
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
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                            ),
                            TextButton(
                              child: Text('Ya'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginApp(),
                                  ),
                                );
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
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Bantuan'),
              onTap: () {
                // Action when Help is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageViewApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color to white
        title: Image.asset(
          'Asset/image/hijau2.png',
          width: 100,
          height: 50,
        ),
        iconTheme:
            IconThemeData(color: Colors.black), // Set the icon color to black
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(
                  'Asset/image/profil.jpg'), // Your profile image path
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('Asset/image/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      'Selamat datang di Pantau Tamu Pro!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Man',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                        builder: (context) => const KunjunganPage(),
                      ),
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
                        builder: (context) => SurveyApp(),
                      ),
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
                        builder: (context) => FeedbackPage(),
                      ),
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
                        builder: (context) => const RiwayatApp(),
                      ),
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
                    text: 'Riwayat kunjungan',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue, // warna ikon saat aktif
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                    color: Colors.grey[500]), // warna ikon saat tidak aktif
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            } else if (index == 1) {
// Show Popup Menu
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    0, MediaQuery.of(context).size.height, 0, 0),
                items: [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text('Buat Kunjungan'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KunjunganPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.bookmark),
                      title: Text('Riwayat kunjungan'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RiwayatApp(),
                          ),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.business),
                      title: Text('Struktur Organisasi'),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StrukturPage(),
                          ),
                        );
                      },
                    ),
                  ),
// Tambahkan item-item baru di sini
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SurveyApp(),
                          ),
                        );
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
                            // Tindakan yang diambil ketika menu Profil dipilih
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const editprofile(), // Gantilah dengan halaman profil Anda
                              ),
                            );
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
                                  content:
                                      Text('Apakah Anda yakin untuk keluar?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Tidak'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Tutup dialog
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Ya'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Tutup dialog
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginApp(),
                                          ),
                                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageViewApp(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (index == 2) {
// Navigate to Profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
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
          elevation: 8, // menambahkan efek shadow
        ),
      ),
    );
  }
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
          width: 80,
          height: 80,
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
