import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Map<String, String>> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FLOATİNGACTİONBUTTON KODLARIM
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.note_add),
                    title: const Text('Not Ekle'),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pop(context);
                      notEkle(context); // Not ekleme penceresini aç
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      //APPBAR KODLARIM
      appBar: AppBar(
        title: const Text(
          "Taskly",
          style: TextStyle(fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.white,
          )
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.white,
        ),
      ),

      //BODY KODLARIM
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'Henüz Bir Not Eklenmedi!',
                style: TextStyle(fontSize: 25),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.teal,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    leading: const Icon(Icons.note),
                    trailing: TextButton(
                      child: const Text(
                        "Güncelle",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        notGuncelle(context, index);
                      },
                    ),
                    title: Text(notes[index]['baslik'] ?? ''),
                    subtitle: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notes[index]['anahtar'] ?? ''),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Eklenme Tarihi: ${notes[index]['tarih']}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      notGoster(
                        context,
                        notes[index]['baslik'] ?? '',
                        notes[index]['icerik'] ?? '',
                      );
                    },
                  ),
                );
              }),
    );
  }

  void notEkle(BuildContext context) {
    TextEditingController baslikController = TextEditingController();
    TextEditingController icerikController = TextEditingController();
    TextEditingController anahtarController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              'Not Ekle',
              style: TextStyle(fontSize: 30),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: baslikController,
                  decoration: const InputDecoration(labelText: 'Başlık'),
                ),
                TextField(
                  controller: icerikController,
                  decoration: const InputDecoration(labelText: 'Açıklama'),
                ),
                TextField(
                  controller: anahtarController,
                  decoration: const InputDecoration(
                      labelText: 'İçerik Konusu',
                      counterText: 'Örn: Painting,Reading Books..'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Kaydet'),
                onPressed: () {
                  setState(() {
                    notes.add({
                      'baslik': baslikController.text,
                      'icerik': icerikController.text,
                      'anahtar': anahtarController.text,
                      'tarih': DateFormat('dd MMM yyyy').format(DateTime.now()),
                      'guncellemeTarihi': '',
                    });
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  } //not ekle fonksiyonum

  void notGoster(BuildContext context, String baslik, String icerik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(baslik),
            content: Column(
              children: [
                Text(icerik),
                const Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'Güncellenme Tarihi: ${DateFormat('dd MMM yyyy HH:mm').format(DateTime.now())}'),
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  child: const Text("Kapat"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dialog'u kapat
                  })
            ],
          ),
        );
      },
    );
  } //not göster fonksiyonum

  void notGuncelle(BuildContext context, int index) {
    TextEditingController baslikController =
        TextEditingController(text: notes[index]['baslik']);
    TextEditingController icerikController =
        TextEditingController(text: notes[index]['icerik']);
    TextEditingController anahtarController =
        TextEditingController(text: notes[index]['anahtar']);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text("Not Güncelle"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: baslikController,
                    decoration: const InputDecoration(labelText: 'Başlık'),
                  ),
                  TextField(
                    controller: icerikController,
                    decoration: const InputDecoration(labelText: 'Açıklama'),
                  ),
                  TextField(
                    controller: anahtarController,
                    decoration:
                        const InputDecoration(labelText: 'İçerik Konusu'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Kapat"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text("Güncelle"),
                  onPressed: () {
                    setState(() {
                      notes[index]['baslik'] = baslikController.text;
                      notes[index]['icerik'] = icerikController.text;
                      notes[index]['anahtar'] = anahtarController.text;
                      notes[index]['guncellemeTarihi'] =
                          DateFormat('dd MMM yyyy').format(DateTime.now());
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  } //Not Güncelle Fonskiyonum
}
