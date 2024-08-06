import 'package:fast_blurhash/fast_blurhash.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(const BlurHashDemo());
}

class BlurHashDemo extends StatefulWidget {
  const BlurHashDemo({super.key});

  @override
  State<BlurHashDemo> createState() => _BlurHashDemoState();
}

class _BlurHashDemoState extends State<BlurHashDemo> {
  final images = [
    "https://i.imgur.com/fU8vqCi.jpeg",
    "https://i.imgur.com/2CXbtO9.jpeg",
    "https://i.imgur.com/54sDohv.jpeg",
  ];

  final hashes = [
    "THEC,t~qWGb=IUxI%ejEIBR~xuaf",
    "TKLpT@?w=V_3RkH=10IU,nT1NGn4",
    "TgDSt8kDWV~qt7WV_3s:ay?bofj@",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox.expand(
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: decodeBlurhash(
                  blurhashString: hashes[index],
                  height: 150,
                  width: 150,
                  punch: 1.0,
                ),
                image: images[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
