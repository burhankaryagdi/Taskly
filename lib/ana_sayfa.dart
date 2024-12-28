import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Map<String,String>> notes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //FLOATİNGACTİONBUTTON KODLARIM
      floatingActionButton:  FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.note_add),
                      title: Text('Not Ekle'),
                      onTap: (){
                        Navigator.pop(context);
                        notEkle(context); // Not ekleme penceresini aç
                      },
                    ),
                  ],
                );
              },
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.teal,
      ),


      //APPBAR KODLARIM
      appBar: AppBar(
        title: Text("Taskly",style: TextStyle(fontSize: 35),),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings),color: Colors.white,)
        ],
        leading: IconButton(onPressed: (){},icon: Icon(Icons.menu),color: Colors.white,),
      ),


      //BODY KODLARIM
      body: notes.isEmpty
          ? Center(
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
                    leading: Icon(Icons.note),
                    trailing: Icon(Icons.keyboard_arrow_right),
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
                              '${notes[index]['tarih']}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
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
            title: Text('Not Ekle',style: TextStyle(fontSize: 30),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                controller: baslikController,
              decoration: InputDecoration(
                labelText: 'Başlık'
              ),
            ),
                TextField(
                  controller: icerikController,
                  decoration: InputDecoration(labelText: 'Açıklama'),
                ),
                TextField(
                  controller: anahtarController,
                  decoration: InputDecoration(
                      labelText: 'İçerik Konusu',
                      counterText: 'Örn: Painting,Reading Books..'),
                ),
              ],
            ),
            actions: [
              TextButton(
                  child: Text('Kapat'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
              ),
              ElevatedButton(
                child: Text('Kaydet'),
                onPressed: () {
                  setState(() {
                    notes.add({
                      'baslik': baslikController.text,
                      'icerik': icerikController.text,
                      'anahtar': anahtarController.text,
                      'tarih': DateFormat('dd MMM yyyy').format(DateTime.now()),
                    });
                    Navigator.of(context).pop();
                  },
              ),
            ],
          );
        },
    );
  }//not ekle fonksiyonum

void notGoster(BuildContext context,String baslik , String icerik){

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(baslik),
            content: Column(
              children: [
                Text(icerik),
                Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat('dd MMM yyyy').format(DateTime.now())),
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  child: Text("Kapat"),
                  onPressed: (){
                    Navigator.of(context).pop(); // Dialog'u kapat
                  }
              )
            ],
          );
        },
    );
}//not göster fonksiyonum


}

