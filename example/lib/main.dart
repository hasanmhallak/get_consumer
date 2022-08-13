import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_consumer/get_consumer.dart';

import 'counter_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GetConsumer<CounterController>(
          controller: _controller,
          listener: (controller) {
            print('object');
          },
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                controller.obx(
                  (state) => Column(
                    children: [
                      Text(
                        'This is state mixin: $state',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Obx(() {
                        return Text(
                          'This is Obx: ${controller.number.value}',
                          style: Theme.of(context).textTheme.headline4,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _controller.updateState(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => _controller.updateNumber(),
            tooltip: 'Increment',
            backgroundColor: Colors.red,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
