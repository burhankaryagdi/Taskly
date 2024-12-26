// Flutter'da model isimleri PascalCase olmalı ve her modelimiz bir nesne olacağı için isimlendirmesi de bu şekilde olmalıdır. Örnek: SaydamPerncere, Araba, Kullanici, TaksiSoforu vb
// Zorunlu olmasa da toJson ve fromJson metodlarını modellere eklemek önemlidir.

class saydamPencereKontrol{
  String baslik;
  String aciklama;

  saydamPencereKontrol(this.baslik, this.aciklama);
}
