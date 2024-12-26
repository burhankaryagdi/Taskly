import 'package:flutter/material.dart';

// Zorunlu olmasa da bir sayfaya ait widgetlerı sayfa classı yazmak daha yaygın bir kullanım. Örnek ekledim.

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  // Sayfa class'ı içinde widget
  // FloatingActionButton buildFloatingActionButton(){
  //   return FloatingActionButton(
  //     onPressed: (){},
  //     child: Icon(Icons.add,color: Colors.white,),
  //   backgroundColor: Colors.teal,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFloatingActionButton(),
      body: buildBody(context),
    );
  }
}



// BODY KODLARIM
Widget buildBody(context){
  bool kontrol1 = true;   // Bu değişkenlerin yeri yanlış. Build fonksiyonu sayfada her setState
  bool kontrol2 = false;  // değişiminde çalışır bu yüzden değişkenler hep sabit kalır.

  return Column(
    children: [
      Center(child: Text("Görevlerim",style: TextStyle(fontSize: 30),)),
      GestureDetector(
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return Dialog(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(15)
                  ),
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        SizedBox(
                       width: double.maxFinite,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Başlık Alanı",
                            ),
                          ),
                         ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width : double.maxFinite,
                            child: TextField(
                              style: TextStyle(fontSize: 20.0,height:10),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Açıklama Alanı...",
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: (){},
                                  child: Text("Kaydet")
                              ),
                              ElevatedButton(
                                  onPressed: (){},
                                  child: Text("Sil")
                              ),
                              ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Kapat")
                              ),
                            ],
                          ),
                    ],
                  ),
                  ),
                  ),
                );
              },
          );
        },
        child: Column(
          children: [
            Card(
              color: Colors.teal,
              elevation: 5,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text("Başlık"),
                subtitle: Text("Alt Başlığımız"),
                leading: Checkbox(
                  value:  kontrol1,
                  onChanged: (bool? value){

                  },
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.white,
              ),
            ),
            Card(
              color: Colors.teal,
              elevation: 5,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text("Başlık 2"),
                subtitle: Text("Alt Başlığımız 2"),
                leading: Checkbox(
                  value: kontrol2,
                  onChanged: (bool? value){

                  },
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.white,
              ),
            ),

          ],
        ),
      ),
    ],
  );
}


// FLOATİNG ACTİON BUTTON KODLARIM
FloatingActionButton buildFloatingActionButton(){
  return FloatingActionButton(
    onPressed: (){},
    child: Icon(Icons.add,color: Colors.white,),
  backgroundColor: Colors.teal,
  );
}


// APPBAR KODLARIM
AppBar buildAppBar(){
  return AppBar(
    title: Text("Taskly",style: TextStyle(fontSize: 35),),
    centerTitle: true,
    backgroundColor: Colors.teal,
    actions: [
      IconButton(onPressed: (){}, icon: Icon(Icons.settings),color: Colors.white,)
    ],
    leading: IconButton(onPressed: (){},icon: Icon(Icons.menu),color: Colors.white,),
  );
}

