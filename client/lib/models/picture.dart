class Picture {
  final String data;
  final String filename;
  Picture({required this.data, required this.filename});

  factory Picture.fromJson(Map json) {
    return Picture(data: json['data'], filename: json['filename']);
  }
}
