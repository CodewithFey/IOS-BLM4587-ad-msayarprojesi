import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String kediAdi = 'Pati';
    const int adimSayisi = 0;
    const int gunlukHedef = 5000;
    const int kalanAdim = gunlukHedef - adimSayisi;
    const int yuzde = adimSayisi * 100 ~/ gunlukHedef;

    return MaterialApp(
      title: 'Adım Sayar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adım Sayar'),
          backgroundColor: Colors.orange[200],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/kedi.png', width: 180),
              const Text(
                'Merhaba, ben $kediAdi!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.directions_walk, size: 40, color: Colors.orange),
              const Text(
                'Bugünkü adımlarım: $adimSayisi',
                style: TextStyle(fontSize: 20),
              ),
              const Text('Günlük hedefim: $gunlukHedef adım'),
              const Text('Hedefe kalan: $kalanAdim adım'),
              const Text('Tamamlanan: %$yuzde'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  debugPrint('Pati: Hadi biraz yürüyelim!');
                },
                child: const Text('Patiye merhaba de'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
