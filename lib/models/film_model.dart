class FilmModel {
  int? id;
  List<String>? sutradara;
  List<String>? aktor;
  List<String>? genre;
  List<String>? negara;
  List<String>? bahasa;
  double? average_rating;
  String? judul;
  String? thumbnail;
  String? status;
  int? tahun;
  String? deskripsi;
  int? durasi;

  FilmModel(
      {this.id,
      this.sutradara,
      this.aktor,
      this.genre,
      this.negara,
      this.bahasa,
      this.average_rating,
      this.judul,
      this.thumbnail,
      this.status,
      this.tahun,
      this.deskripsi,
      this.durasi});

  FilmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sutradara = List<String>.from(json['sutradara']);
    aktor = List<String>.from(json['aktor']);
    genre = List<String>.from(json['genre']);
    negara = List<String>.from(json['negara']);
    bahasa = List<String>.from(json['bahasa']);
    average_rating = json['average_rating'];
    judul = json['judul'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    tahun = json['tahun'];
    deskripsi = json['deskripsi'];
    durasi = json['durasi'];
  }
}
