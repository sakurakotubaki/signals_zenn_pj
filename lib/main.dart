import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Counter(),
    );
  }
}


class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> with SignalsMixin {
  late final counter = createSignal(0);
  late final isEven = createComputed(() => counter.value.isEven);
  late final isOdd = createComputed(() => counter.value.isOdd);

  @override
  Widget build(BuildContext context) {
	return Scaffold(
      appBar: AppBar(
        title: const Text('Signals Example'),
      ),
      body: Center(
        child: Column(
          children: [
          Text('Counter: $counter'), // <- No need to use .value since .toString() is overridden to return the value
          Text('Is Even: $isEven'),
          Text('Is Odd: $isOdd'),
          ElevatedButton(
            onPressed: () => counter.value++,
            child: Text('Increment'),
          ),
          ],
        ),
      ),
    );
  }
}