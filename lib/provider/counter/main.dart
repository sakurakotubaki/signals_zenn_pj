import 'package:signals/signals_flutter.dart';
import 'package:flutter/material.dart';

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
        useMaterial3: true,
      ),
      home: const Example(),
    );
  }
}

class Counter extends FlutterSignal<int> {
  Counter([super.value = 0]);

  void increment() => value++;
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalProvider<Counter>(
      create: () => Counter(0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Builder(builder: (context) {
                final counter = SignalProvider.of<Counter>(context);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          final counter = SignalProvider.of<Counter>(context, listen: false)!;
          return FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}