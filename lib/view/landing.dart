import 'package:flutter/material.dart';
import 'package:pantau_pro/register/login.dart';

void main() {
  runApp(const landingapp());
}

class landingapp extends StatefulWidget {
  const landingapp({super.key});

  @override
  _landingappState createState() => _landingappState();
}

class _landingappState extends State {
  bool _isEnglish = false;

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantau Tamu Pro',
      theme: ThemeData(
        primaryColor: Colors.orange,
        hintColor: Colors.orangeAccent,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 157, 0),
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(color: Color.fromARGB(221, 255, 255, 255)),
        ),
      ),
      home: MyHomePage(
        isEnglish: _isEnglish,
        toggleLanguage: _toggleLanguage,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback toggleLanguage;

  const MyHomePage({super.key, required this.isEnglish, required this.toggleLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'Asset/image/mdr.png',
          width: 100,
          height: 100,
        ),
        backgroundColor: Colors.transparent, // Buat latar belakang transparan
        elevation: 0,
        actions: [
          TextButton(
            onPressed: toggleLanguage,
            child: Text(
              isEnglish ? 'Bahasa Indonesia' : 'English',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        isEnglish ? 'Monitor \n' : 'Pantau \n', // Teks pertama
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Man',
                      letterSpacing: 7,
                    ),
                  ),
                  TextSpan(
                    text: isEnglish ? 'Guest Pro' : 'Tamu Pro', // Teks kedua
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Man',
                      height: 0.8,
                      letterSpacing: 5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 2,
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginApp(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(-1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                ),
                child: Text(
                  isEnglish ? 'Create Visit' : 'Buat Kunjungan',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        isEnglish ? 'Powered By Uta.' : 'Didukung Oleh Uta.',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
