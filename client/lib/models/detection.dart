// ignore_for_file: non_constant_identifier_names

class Detection {
  final String time;
  final String license_number;
  final double accuracy;
  final String filename;
  final String camLocation;
  const Detection(
      {required this.time,
      required this.license_number,
      required this.accuracy,
      required this.filename,
      required this.camLocation});

  factory Detection.fromJson(Map json) {
    return Detection(
        time: json['time'],
        license_number: json['license_number'],
        accuracy: json['accuracy'],
        filename: json['filename'],
        camLocation: json['cam']);
  }
}

/*
final detections = <Detection>[
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
  const Detection(
      date: "dawfcbwav",
      time: "asdascw",
      detection: "asdasd",
      accuracy: "asdasd"),
];
*/