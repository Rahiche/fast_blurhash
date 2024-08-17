import 'dart:typed_data';
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

  bool useAsync = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BlurHash Demo'),
          actions: [
            Switch(
              value: useAsync,
              onChanged: (value) {
                setState(() {
                  useAsync = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(useAsync ? 'Async' : 'Sync'),
              ),
            ),
          ],
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            if (useAsync) {
              return FastBlurhashWidgetBuilder(blurhashString: hashes[index]);
            }
            return SizedBox.expand(
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: decodeBlurhash(blurhashString: hashes[index]),
                fadeInDuration: const Duration(seconds: 2),
                fadeOutDuration: const Duration(seconds: 2),
                image: images[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FastBlurhashWidgetBuilder extends StatefulWidget {
  const FastBlurhashWidgetBuilder({
    super.key,
    required this.blurhashString,
    this.height = 32,
    this.width = 32,
    this.punch = 1.0,
    this.enableCache = true,
    this.child,
  });

  final String blurhashString;
  final int height;
  final int width;
  final double punch;
  final bool enableCache;
  final Widget? child;

  @override
  State<FastBlurhashWidgetBuilder> createState() =>
      _FastBlurhashWidgetBuilderState();
}

class _FastBlurhashWidgetBuilderState extends State<FastBlurhashWidgetBuilder> {
  late Future<Uint8List> _blurhashFuture;

  @override
  void initState() {
    super.initState();
    _blurhashFuture = decodeBlurhashIsolate(
      blurhashString: widget.blurhashString,
      height: widget.height,
      width: widget.width,
      punch: widget.punch,
      enableCache: widget.enableCache,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _blurhashFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Stack(
            children: [
              Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              if (widget.child != null) widget.child!,
            ],
          );
        } else {
          return widget.child ?? Container(color: Colors.transparent);
        }
      },
    );
  }
}
