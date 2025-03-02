import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  ThemeData createTheme(BuildContext context, Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: brightness,
      ),
      brightness: brightness,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: const CounterExample(),
    );
  }
}

enum Status {
  TODO('未着手'),
  INPROGRESS('開始'),
  DONE('終了');

  final String description;

  const Status(this.description);
}

class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> with SignalsMixin {
  // action chip
  late var favorite = createSignal(false);
  // switch light
  late final Signal<bool> light = createSignal(false);
  // checkbox
  late final Signal<bool> isDone = createSignal(false); 
  // drop down
  late final Signal<Status> status = createSignal(Status.TODO);
  // slider
  late final Signal<double> slider = createSignal(0.0);
  // counter
  late final Signal<int> counter = createSignal(0);
  // counter increment
  void _incrementCounter() {
    counter.value++;
  }
  // toggle
  void toggle() => isDone.value = !isDone.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // switch light
            Switch(
              value: light.value,
              activeColor: Colors.amber,
              onChanged: (value) => light.value = value,
            ),
            // action chip
            ActionChip(
          avatar: Icon(favorite.value
          ? Icons.favorite : Icons.favorite_border),
          label: const Text('Save to favorites'),
          onPressed: () {
            favorite.value = !favorite.value;
          },
        ),
            // slider
            Text('Slider value: ${slider.value}'),
            Slider(
              value: slider.value,
              onChanged: (value) => slider.value = value,
              min: 0,
              max: 100,
              divisions: 100,
            ),
            // drop down
            DropdownButton<Status>(
              value: status.value,
              onChanged: (Status? value) {
                status.value = value!;
              },
              items: Status.values
                  .map((Status status) => DropdownMenuItem<Status>(
                        value: status,
                        child: Text(status.description),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            // checkbox
            Checkbox(
              value: isDone.value,
              onChanged: (value) => toggle(),
            ),
            const SizedBox(height: 16),
            const Text(
              'You have pushed the button this many times:',
            ),
            // counter
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}