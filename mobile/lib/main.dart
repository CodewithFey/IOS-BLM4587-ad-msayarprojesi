import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adım Sayar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  String kediResmi(int adim, int hedef) {
    if (adim == 0) {
      return 'assets/images/kedi_uykulu.png';
    } else if (adim < hedef) {
      return 'assets/images/kedi_mutlu.png';
    } else {
      return 'assets/images/kedi_heyecanli.png';
    }
  }

  String kediMesaji(int adim, int hedef) {
    if (adim == 0) {
      return 'Hadi beni yürüyüşe çıkar!';
    } else if (adim < hedef) {
      return 'Devam et, az kaldı!';
    } else {
      return 'Harikasın, hedef tamam!';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String kediAdi = 'Pati';
    const int adimSayisi = 0;
    const int gunlukHedef = 5000;
    const int yuzde = adimSayisi * 100 ~/ gunlukHedef;

    int kalanAdim = gunlukHedef - adimSayisi;
    if (kalanAdim < 0) {
      kalanAdim = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adım Sayar'),
        backgroundColor: Colors.orange[200],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(kediResmi(adimSayisi, gunlukHedef), width: 160),
            const Text(
              'Merhaba, ben $kediAdi!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              kediMesaji(adimSayisi, gunlukHedef),
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.directions_walk, size: 40, color: Colors.orange),
                  Text(
                    '$adimSayisi',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Text('bugünkü adım'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: BilgiKutusu(baslik: 'Hedef', deger: '$gunlukHedef'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BilgiKutusu(baslik: 'Kalan', deger: '$kalanAdim'),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: BilgiKutusu(baslik: 'Tamamlanan', deger: '%$yuzde'),
                ),
              ],
            ),
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
    );
  }
}

class BilgiKutusu extends StatelessWidget {
  const BilgiKutusu({super.key, required this.baslik, required this.deger});

  final String baslik;
  final String deger;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              deger,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(baslik, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
