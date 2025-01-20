
class ItemModel {
  final int id;
  final String nama_pelanggan;
  final int durasi;
  final int nomor_biling;

  ItemModel({
    required this.id,
    required this.nama_pelanggan,
    required this.durasi,
    required this.nomor_biling,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? 0,
      nama_pelanggan: json['nama_pelanggan'] ?? '',
      durasi: json['durasi'] ?? 0,
      nomor_biling: json['nomor_biling'] ?? 0,
    );  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_pelanggan': nama_pelanggan,
    'durasi': durasi,
    'nomor_biling': nomor_biling,
  };
}