import 'package:perpus/models/perpus_model.dart';


class PerpusController {
  List<PerpusModel> book = [
    PerpusModel(
      id: 1,
      judul: 'Dilan 1990',
      deskripsi: 'Percintaan',
      penerbit: 'Mizan Group',
      fotoBuku: 'assets/dilan 1990.jpg',
      pengarang: 'Pidi Baiq',
      stok: 3,

    ),
    PerpusModel(
      id: 2,
      judul: 'Laut Bercerita',
      deskripsi: 'Percintaan',
      penerbit: 'Mizan Group',
      fotoBuku: 'assets/dilan 1991.jpg',
      pengarang: 'Pidi Baiq',
      stok: 9,
    ),
  ];

}