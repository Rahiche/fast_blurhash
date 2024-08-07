import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_blurhash/flutter_blurhash.dart' as flutter_blurhash;

import 'package:fast_blurhash/fast_blurhash.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Uint8List? imageBytes;
  List<Duration> _durations = [];
  double avgTimeRust = 0;
  double avgTimeDart = 0;
  int bestTimeRust = 0;
  int worstTimeRust = 0;
  int bestTimeDart = 0;
  int worstTimeDart = 0;

  void updateStats(List<Duration> durations, bool isRust) {
    _durations = List.from(durations);
    int totalMicroseconds =
        durations.fold(0, (sum, duration) => sum + duration.inMicroseconds);
    double avgMicroseconds = totalMicroseconds / durations.length;
    int bestMicroseconds =
        durations.map((e) => e.inMicroseconds).reduce((a, b) => a < b ? a : b);
    int worstMicroseconds =
        durations.map((e) => e.inMicroseconds).reduce((a, b) => a > b ? a : b);

    setState(() {
      _durations = List.from(durations);
      if (isRust) {
        avgTimeRust = avgMicroseconds;
        bestTimeRust = bestMicroseconds;
        worstTimeRust = worstMicroseconds;
      } else {
        avgTimeDart = avgMicroseconds;
        bestTimeDart = bestMicroseconds;
        worstTimeDart = worstMicroseconds;
      }
    });
  }

  final hashes = [
    "THEC,t~qWGb=IUxI%ejEIBR~xuaf",
    "TKLpT@?w=V_3RkH=10IU,nT1NGn4",
    "TgDSt8kDWV~qt7WV_3s:ay?bofj@",
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Benchmarking App")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() => isLoading = true);
                      List<Duration> durations = [];

                      for (int i = 0; i < 500; i++) {
                        final hash =
                            hashes[Random.secure().nextInt(hashes.length - 1)];
                        await Future.delayed(const Duration(milliseconds: 100));
                        final stopwatch = Stopwatch()..start();

                        imageBytes = decodeBlurhash(
                          blurhashString: hash,
                          height: 150,
                          width: 150,
                          punch: 1.0,
                          enableCache: false,
                        );
                        stopwatch.stop();
                        final elapsedTime = stopwatch.elapsedMicroseconds;
                        durations.add(Duration(microseconds: elapsedTime));
                      }

                      updateStats(durations, true);
                      setState(() => isLoading = false);
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("RUST"),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() => isLoading = true);
                      List<Duration> durations = [];

                      for (int i = 0; i < 500; i++) {
                        final hash =
                            hashes[Random.secure().nextInt(hashes.length - 1)];

                        await Future.delayed(const Duration(milliseconds: 100));
                        final stopwatch = Stopwatch()..start();
                        const width = 150;
                        const height = 150;

                        imageBytes = await flutter_blurhash.blurHashDecode(
                          blurHash: hash,
                          width: width,
                          height: height,
                        );
                        stopwatch.stop();
                        final elapsedTime = stopwatch.elapsedMicroseconds;
                        durations.add(Duration(microseconds: elapsedTime));
                      }
                      updateStats(durations, false);
                      setState(() => isLoading = false);
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("DART"),
            ),
          ],
        ),
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "RUST Benchmark",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Average Time: $avgTimeRust µs"),
                  Text("Best Time: $bestTimeRust µs"),
                  Text("Worst Time: $worstTimeRust µs"),
                  const SizedBox(height: 20),
                  const Text(
                    "DART Benchmark",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Average Time: $avgTimeDart µs"),
                  Text("Best Time: $bestTimeDart µs"),
                  Text("Worst Time: $worstTimeDart µs"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _durations.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      _durations[index].inMicroseconds.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
