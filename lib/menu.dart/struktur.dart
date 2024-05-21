import 'package:flutter/material.dart';
import 'package:pantau_pro/register/Home_page.dart';

void main() {
  runApp(MaterialApp(
    home: StrukturPage(),
  ));
}

class StrukturPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Struktur Organisasi',
          style:
              TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Color.fromARGB(
            255, 11, 86, 199), // Jadikan latar belakang transparan
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Ubah warna ikon menjadi putih
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        elevation: 0, // Hilangkan bayangan di bawah AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade400,
            ], // Ubah warna gradasi sesuai keinginan
          ),
        ),
        child: Center(
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 4.0,
            panEnabled:
                true, // Memungkinkan pengguna untuk menggeser gambar saat di-zoom
            child: Image.asset(
              'Asset/image/struktur.png', // Ganti dengan path gambar Anda
              width: MediaQuery.of(context)
                  .size
                  .width, // Ukuran gambar sesuai lebar layar
              fit: BoxFit.fitWidth, // Mengatur agar gambar memenuhi lebar layar
            ),
          ),
        ),
      ),
    );
  }
}
