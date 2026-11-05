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

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final String _kediAdi = 'Pati';
  int _adimSayisi = 0;
  int _gunlukHedef = 5000;

  String _kediResmi(int yuzde) {
    if (yuzde == 0) {
      return 'assets/images/kedi_uykulu.png';
    } else if (yuzde < 100) {
      return 'assets/images/kedi_mutlu.png';
    } else {
      return 'assets/images/kedi_heyecanli.png';
    }
  }

  String _kediMesaji(int yuzde) {
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

  void _mesajGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaj)));
  }

  void _hedefiArttir() {
    setState(() {
      _gunlukHedef = _gunlukHedef + 500;
    });
  }

  void _hedefiAzalt() {
    if (_gunlukHedef <= 1000) {
      _mesajGoster('Günlük hedef 1000 adımdan az olamaz');
      return;
    }
    setState(() {
      _gunlukHedef = _gunlukHedef - 500;
    });
  }

  void _adimEkle() {
    bool hedefeUlasmadi = _adimSayisi < _gunlukHedef;
    setState(() {
      _adimSayisi = _adimSayisi + 500;
    });
    if (hedefeUlasmadi && _adimSayisi >= _gunlukHedef) {
      _mesajGoster('Tebrikler, bugünkü hedefine ulaştın!');
    }
  }

  Future<void> _sifirlamayiOnayla() async {
    final bool? onay = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adımlar sıfırlansın mı?'),
        content: const Text('Bugünkü adım sayın 0 olacak.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sıfırla'),
          ),
        ],
      ),
    );
    if (onay == true) {
      setState(() {
        _adimSayisi = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int kalanAdim = _gunlukHedef - _adimSayisi;
    if (kalanAdim < 0) {
      kalanAdim = 0;
    }

    int yuzde = _adimSayisi * 100 ~/ _gunlukHedef;
    if (yuzde > 100) {
      yuzde = 100;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adım Sayar'),
        backgroundColor: Colors.orange[200],
        actions: [
          IconButton(
            onPressed: _adimSayisi == 0 ? null : _sifirlamayiOnayla,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_kediResmi(yuzde), width: 170),
                  Text(
                    'Merhaba, ben $_kediAdi!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _kediMesaji(yuzde),
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          _mesajGoster(
                            '$_kediAdi: Miyav! Hadi biraz yürüyelim.',
                          );
                        },
                        child: const Text('Patiye merhaba de'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: _adimEkle,
                        child: const Text('+500 adım'),
                      ),
                    ],
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
                  Text(
                    '$_adimSayisi / $_gunlukHedef adım',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: _hedefiAzalt,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                Text(
                  'Günlük hedef: $_gunlukHedef',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                FilledButton.tonal(
                  onPressed: _hedefiArttir,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
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
