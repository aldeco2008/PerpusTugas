class PerpusModel {
  int id;
  String judul;
  String deskripsi;
  double? stok;
  String fotoBuku;
  String penerbit;
  String pengarang;
  PerpusModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    this.stok,
    required this.fotoBuku,
    required this.penerbit,
    required this.pengarang,
  });
}