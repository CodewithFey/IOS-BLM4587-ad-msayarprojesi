const express = require('express');

const app = express();
const port = 3000;

app.use(express.json());
app.use('/resimler', express.static('public/resimler'));

const aksesuarlar = [
  { id: 1, ad: 'Parti Şapkası', bolge: 'bas', fiyat: 300, resim: 'parti_sapkasi.png' },
  { id: 2, ad: 'Uyku Şapkası', bolge: 'bas', fiyat: 120, resim: 'uyku_sapkasi.png' },
  { id: 3, ad: 'Çiçek Taç', bolge: 'bas', fiyat: 250, resim: 'cicek_tac.png' },
  { id: 4, ad: 'Gözlük', bolge: 'yuz', fiyat: 400, resim: 'gozluk.png' },
  { id: 5, ad: 'Kırmızı Fular', bolge: 'boyun', fiyat: 700, resim: 'kirmizi_fular.png' },
];

app.get('/', (req, res) => {
  res.send('Adım Sayar API çalışıyor');
});

app.get('/api/aksesuarlar', (req, res) => {
  res.json(aksesuarlar);
});

app.get('/api/aksesuarlar/:id', (req, res) => {
  const id = Number(req.params.id);
  const aksesuar = aksesuarlar.find((a) => a.id === id);

  if (!aksesuar) {
    return res.status(404).json({ mesaj: 'Aksesuar bulunamadı' });
  }

  res.json(aksesuar);
});

app.listen(port, () => {
  console.log(`API ${port} portunda çalışıyor`);
});
