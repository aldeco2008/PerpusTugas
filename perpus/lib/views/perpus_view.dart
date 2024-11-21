import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perpus/controller/perpus_controller.dart';
import 'package:perpus/models/perpus_model.dart';
import 'package:perpus/views/modal.dart';

class PerpusView extends StatefulWidget {
  const PerpusView({super.key});

  @override
  State<PerpusView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<PerpusView> {
  final formKey = GlobalKey<FormState>();
  PerpusController book = PerpusController();
  TextEditingController judul = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController fotoBuku = TextEditingController();
  TextEditingController pengarang = TextEditingController();
  TextEditingController penerbit = TextEditingController();
  TextEditingController stok = TextEditingController();
  List buttonChoice = ["Update", "Hapus"];
  List? library;
  int? library_id;

  getLibrary() {
    setState(() {
      library = book.book;
    });
  }

  @override
  void initState() {
    super.initState();
    getLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PerOn (Perpustakaan Online)"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  library_id = null;
                });
                judul.clear();
                deskripsi.clear();
                penerbit.clear();
                fotoBuku.clear();
                pengarang.clear();
                stok.clear();
                ModalWidget().showFullModal(context, addItem(null));
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        itemCount: library!.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(library![index].fotoBuku),
                        width: 80,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              library![index].judul,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Pengarang: ${library![index].pengarang}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              'Penerbit: ${library![index].penerbit}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Stok: ${library![index].stok}',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return buttonChoice.map((r) {
                            return PopupMenuItem(
                              value: r,
                              child: Text(r),
                              onTap: () {
                                if (r == "Update") {
                                  setState(() {
                                    library_id = library![index].id;
                                  });

                                  judul.text = library![index].judul;
                                  deskripsi.text = library![index].deskripsi;
                                  penerbit.text = library![index].penerbit;
                                  pengarang.text = library![index].pengarang;
                                  fotoBuku.text = library![index].fotoBuku;
                                  stok.text = library![index].stok.toString();
                                  ModalWidget().showFullModal(context, addItem(index));
                                } else if (r == "Hapus") {
                                  setState(() {
                                    library!.removeAt(index);
                                  });
                                }
                              },
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Deskripsi:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    library![index].deskripsi,
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget addItem(int? index) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              index == null ? "Tambah Buku" : "Update Data Buku",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: judul,
              decoration: InputDecoration(label: Text("Judul")),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Judul is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: deskripsi,
              decoration: InputDecoration(label: Text("Deskripsi")),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Deskripsi is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: penerbit,
              decoration: InputDecoration(label: Text("Penerbit")),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Penerbit is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: fotoBuku,
              decoration: InputDecoration(label: Text("Foto Buku")),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Foto Buku is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: pengarang,
              decoration: InputDecoration(label: Text("Pengarang")),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Pengarang is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: stok,
              decoration: InputDecoration(label: Text("Stok")),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Stok is required';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (index != null) {
                    setState(() {
                      library![index].judul = judul.text;
                      library![index].deskripsi = deskripsi.text;
                      library![index].penerbit = penerbit.text;
                      library![index].pengarang = pengarang.text;
                      library![index].fotoBuku = fotoBuku.text;
                      library![index].stok = int.parse(stok.text);
                    });
                    Navigator.pop(context);
                  } else {
                    int _id_library = library!.length + 1;
                    setState(() {
                      library!.add(PerpusModel(
                        id: _id_library,
                        judul: judul.text,
                        deskripsi: deskripsi.text,
                        penerbit: penerbit.text,
                        pengarang: pengarang.text,
                        fotoBuku: fotoBuku.text,
                        stok: double.parse(stok.text),
                      ));
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(index == null ? "Simpan" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}