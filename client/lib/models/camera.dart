class Camera {
  final String name;
  final String port;
  Camera({
    this.name = "",
    this.port = "",
  });
  factory Camera.fromJson(Map? json) {
    if (json == null) {
      return Camera(name: "", port: "");
    }
    return Camera(name: json['name'], port: json['port']);
  }
}
