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
  List<Duration> _durationsRust = [];
  List<Duration> _durationsDart = [];
  int avgTimeRust = 0;
  int avgTimeDart = 0;
  int bestTimeRust = 0;
  int worstTimeRust = 0;
  int bestTimeDart = 0;
  int worstTimeDart = 0;
  double _width = 32;
  double _height = 32;
  double _iterations = 500;

  void updateStats(List<Duration> durations, bool isRust) {
    int totalMicroseconds =
        durations.fold(0, (sum, duration) => sum + duration.inMicroseconds);
    double avgMicroseconds = totalMicroseconds / durations.length;
    int bestMicroseconds =
        durations.map((e) => e.inMicroseconds).reduce((a, b) => a < b ? a : b);
    int worstMicroseconds =
        durations.map((e) => e.inMicroseconds).reduce((a, b) => a > b ? a : b);

    setState(() {
      if (isRust) {
        _durationsRust = List.from(durations);
        avgTimeRust = avgMicroseconds.toInt();
        bestTimeRust = bestMicroseconds;
        worstTimeRust = worstMicroseconds;
      } else {
        _durationsDart = List.from(durations);
        avgTimeDart = avgMicroseconds.toInt();
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

                      for (int i = 0; i < _iterations.toInt(); i++) {
                        final hash =
                            hashes[Random.secure().nextInt(hashes.length - 1)];
                        await Future.delayed(const Duration(milliseconds: 100));
                        final stopwatch = Stopwatch()..start();

                        imageBytes = decodeBlurhash(
                          blurhashString: hash,
                          height: _height.toInt(),
                          width: _width.toInt(),
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

                      for (int i = 0; i < _iterations.toInt(); i++) {
                        final hash =
                            hashes[Random.secure().nextInt(hashes.length - 1)];

                        await Future.delayed(const Duration(milliseconds: 100));
                        final stopwatch = Stopwatch()..start();

                        imageBytes = await flutter_blurhash.blurHashDecode(
                          blurHash: hash,
                          width: _width.toInt(),
                          height: _height.toInt(),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Slider(
                    value: _width,
                    min: 8,
                    max: 512,
                    divisions: 50,
                    label: 'Width: ${_width.toInt()}',
                    onChanged: (double value) {
                      setState(() {
                        _width = value;
                      });
                    },
                  ),
                  Slider(
                    value: _height,
                    min: 8,
                    max: 512,
                    divisions: 50,
                    label: 'Height: ${_height.toInt()}',
                    onChanged: (double value) {
                      setState(() {
                        _height = value;
                      });
                    },
                  ),
                  Slider(
                    value: _iterations,
                    min: 10,
                    max: 1000,
                    divisions: 100,
                    label: 'Iterations: ${_iterations.toInt()}',
                    onChanged: (double value) {
                      setState(() {
                        _iterations = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "RUST Benchmark",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("Average Time: $avgTimeRust µs"),
                        Text("Best Time: $bestTimeRust µs"),
                        Text("Worst Time: $worstTimeRust µs"),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _durationsRust.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(
                                  _durationsRust[index].inMicroseconds.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "DART Benchmark",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("Average Time: $avgTimeDart µs"),
                        Text("Best Time: $bestTimeDart µs"),
                        Text("Worst Time: $worstTimeDart µs"),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _durationsDart.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(
                                  _durationsDart[index].inMicroseconds.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
