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

class CheckSignal extends FlutterSignal<bool> {
  CheckSignal([super.value = false]);

  void toggle() => value = !value;
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalProvider<CheckSignal>(
      create: () => CheckSignal(false),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('CheckBox'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Builder(builder: (context) {
                final counter = SignalProvider.of<CheckSignal>(context);
                return Checkbox(
                    value: counter?.value,
                    onChanged: (value) {
                      if (value != null) {
                        counter?.value = value;
                      }
                    });
              }),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          final check = SignalProvider.of<CheckSignal>(context, listen: false)!;
          return FloatingActionButton(
            onPressed: check.toggle,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}