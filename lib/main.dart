import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

// Создание провайдера для RandomDataService
final randomDataProvider = ChangeNotifierProvider((ref) => RandomDataService());

// Сервис для работы с рандомными данными
class RandomDataService extends ChangeNotifier {
  void addRandomData() {
    final randomData = randomAlpha(10); // Генерируем случайные данные
    print('Random data added: $randomData');
    notifyListeners(); // Уведомляем слушателей об изменениях
  }
}

// Клиент для взаимодействия с RandomDataService
class RandomDataClient {
  final RandomDataService _randomDataService;

  RandomDataClient(
      this._randomDataService); // Внедрение зависимости RandomDataService через конструктор

  void addRandomData() {
    _randomDataService.addRandomData(); // Вызов метода addRandomData у сервиса
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Dependency Injection Example with Riverpod',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Directionality(
          textDirection:
              TextDirection.ltr, // Установите нужное направление текста
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomDataClient = RandomDataClient(ref.watch(randomDataProvider));
    return MyHomePage(randomDataClient: randomDataClient);
  }
}

class MyHomePage extends ConsumerWidget {
  final RandomDataClient randomDataClient;

  MyHomePage({required this.randomDataClient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dependency Injection Example with Riverpod'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Generate Random Data:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                randomDataClient.addRandomData();
              },
              child: Text('Generate Data'),
            ),
          ],
        ),
      ),
    );
  }
}
