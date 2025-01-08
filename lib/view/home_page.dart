import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:taskly/model/note.dart';
import 'package:taskly/view_model/note_view_model.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          notEkle(context);
        },
      ),
      appBar: AppBar(
        title: const Text("Taskly", style: TextStyle(fontSize: 35)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Consumer<NoteViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.notes.isEmpty
              ? const Center(
                  child: Text('Henüz Bir Not Eklenmedi!',
                      style: TextStyle(fontSize: 25)))
              : ListView.builder(
                  itemCount: viewModel.notes.length,
                  itemBuilder: (context, index) {
                    var note = viewModel.notes[index];
                    return Card(
                      color: Colors.teal,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: ListTile(
                        leading: const Icon(Icons.note),
                        title: Text(note.baslik,style: TextStyle(fontSize: 20),),
                        subtitle: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(note.anahtar,style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            Text('Eklenme Tarihi: ${note.tarih}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12)),
                          ],
                        ),
                        trailing: TextButton(
                          child: const Text("Güncelle",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            notGuncelle(context, index);
                          },
                        ),
                        onTap: () {
                          notGoster(context, note.baslik, note.icerik);
                        },
                      ),
                    );
                  },
                );
        },
      ),
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
            title: const Text('Not Ekle', style: TextStyle(fontSize: 30)),
            content: Column(
              children: [
                TextField(
                    controller: baslikController,
                    decoration: const InputDecoration(labelText: 'Başlık')),
                TextField(
                    controller: icerikController,
                    decoration: const InputDecoration(labelText: 'Açıklama')),
                TextField(
                    controller: anahtarController,
                    decoration:
                        const InputDecoration(labelText: 'İçerik Konusu')),
              ],
            ),
            actions: [
              TextButton(
                  child: const Text('Kapat'),
                  onPressed: () => Navigator.of(context).pop()),
              ElevatedButton(
                child: const Text('Kaydet'),
                onPressed: () {
                  var newNote = Note(
                    baslik: baslikController.text,
                    icerik: icerikController.text,
                    anahtar: anahtarController.text,
                    tarih: DateFormat('dd MMM yyyy').format(DateTime.now()),
                  );
                  Provider.of<NoteViewModel>(context, listen: false)
                      .addNote(newNote);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void notGoster(BuildContext context, String baslik, String icerik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(baslik),
            content: Column(
              children: [
                Text(icerik),
                Text(
                    'Güncellenme Tarihi: ${DateFormat('dd MMM yyyy HH:mm').format(DateTime.now())}')
              ],
            ),
            actions: [
              TextButton(
                  child: const Text("Kapat"),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
        );
      },
    );
  }

  void notGuncelle(BuildContext context, int index) {
    TextEditingController baslikController = TextEditingController(
        text: Provider.of<NoteViewModel>(context, listen: false)
            .notes[index]
            .baslik);
    TextEditingController icerikController = TextEditingController(
        text: Provider.of<NoteViewModel>(context, listen: false)
            .notes[index]
            .icerik);
    TextEditingController anahtarController = TextEditingController(
        text: Provider.of<NoteViewModel>(context, listen: false)
            .notes[index]
            .anahtar);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text("Not Güncelle"),
            content: Column(
              children: [
                TextField(
                    controller: baslikController,
                    decoration: const InputDecoration(labelText: 'Başlık')),
                TextField(
                    controller: icerikController,
                    decoration: const InputDecoration(labelText: 'Açıklama')),
                TextField(
                    controller: anahtarController,
                    decoration:
                        const InputDecoration(labelText: 'İçerik Konusu')),
              ],
            ),
            actions: [
              TextButton(
                  child: const Text("Kapat"),
                  onPressed: () => Navigator.of(context).pop()),
              ElevatedButton(
                child: const Text("Güncelle"),
                onPressed: () {
                  var updatedNote = Note(
                    baslik: baslikController.text,
                    icerik: icerikController.text,
                    anahtar: anahtarController.text,
                    tarih: Provider.of<NoteViewModel>(context, listen: false)
                        .notes[index]
                        .tarih,
                    guncellemeTarihi:
                        DateFormat('dd MMM yyyy').format(DateTime.now()),
                  );
                  Provider.of<NoteViewModel>(context, listen: false)
                      .updateNote(index, updatedNote);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
