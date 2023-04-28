class ImageDetails {
  final String cardata, plateData;
  ImageDetails({required this.cardata, required this.plateData});

  factory ImageDetails.fromJson(Map json) {
    return ImageDetails(
        cardata: json['car']['data'], plateData: json['plate']['data']);
  }
}
