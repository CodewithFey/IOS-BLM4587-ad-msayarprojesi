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

  String kediResmi(int yuzde) {
    if (yuzde == 0) {
      return 'assets/images/kedi_uykulu.png';
    } else if (yuzde < 100) {
      return 'assets/images/kedi_mutlu.png';
    } else {
      return 'assets/images/kedi_heyecanli.png';
    }
  }

  String kediMesaji(int yuzde) {
    if (yuzde == 0) {
      return 'Bugün yeni başlıyoruz, hoş geldin!';
    } else if (yuzde < 50) {
      return 'Güzel başladık, devam edelim!';
    } else if (yuzde < 100) {
      return 'Az kaldı, hadi biraz daha!';
    } else {
      return 'Tebrikler, hedefe ulaştın!';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String kediAdi = 'Pati';
    const int adimSayisi = 0;
    const int gunlukHedef = 5000;

    int kalanAdim = gunlukHedef - adimSayisi;
    if (kalanAdim < 0) {
      kalanAdim = 0;
    }

    int yuzde = adimSayisi * 100 ~/ gunlukHedef;
    if (yuzde > 100) {
      yuzde = 100;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adım Sayar'),
        backgroundColor: Colors.orange[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kediResmi(yuzde), width: 200),
                  const Text(
                    'Merhaba, ben $kediAdi!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kediMesaji(yuzde),
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint('Pati: Hadi biraz yürüyelim!');
                    },
                    child: const Text('Patiye merhaba de'),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    '$adimSayisi / $gunlukHedef adım',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: yuzde / 100,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFEDE8E3),
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
                Expanded(
                  child: BilgiKutusu(baslik: 'Tamamlanan', deger: '%$yuzde'),
                ),
              ],
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
