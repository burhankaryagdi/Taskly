class Note {
  String baslik;
  String icerik;
  String anahtar;
  String tarih;
  String? guncellemeTarihi;

  Note({
    required this.baslik,
    required this.icerik,
    required this.anahtar,
    required this.tarih,
    this.guncellemeTarihi,
  });
}
