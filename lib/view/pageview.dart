import 'package:flutter/material.dart';

void main() {
  runApp(PageViewApp());
}

class PageViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyImageSlider(),
    );
  }
}

class MyImageSlider extends StatefulWidget {
  @override
  _MyImageSliderState createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {
  int currentPage = 0;

  final List<String> images = [
    "Asset/image/5.png",
    "Asset/image/6.png", // Ganti dengan gambar yang berbeda jika perlu
    "Asset/image/7.png", // Ganti dengan gambar yang berbeda jika perlu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Slider'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Page ${currentPage + 1} of ${images.length}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
