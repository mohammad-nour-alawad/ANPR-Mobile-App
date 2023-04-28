import 'dart:convert';

import 'package:client/api.dart';
import 'package:flutter/material.dart';
import 'package:client/models/detection.dart';

class DetectionDetailsScreen extends StatefulWidget {
  DetectionDetailsScreen({Key? key, required this.det, required this.filename})
      : super(key: key);

  final Detection det;
  final String filename;

  final Api api = Api();
  @override
  _DetectionDetailsScreen createState() => _DetectionDetailsScreen();
}

class _DetectionDetailsScreen extends State<DetectionDetailsScreen> {
  String carData = "";
  String plateData = "";
  bool loading = true;

  @override
  void initState() {
    _getImageCar();
    super.initState();
  }

  void _getImageCar() async {
    widget.api.getDetialsImages(widget.filename).then((value) => setState(() {
          carData = value.cardata;
          plateData = value.plateData;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.det.license_number)),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(base64Decode((carData))),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.45),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            child: Container(
                              width: 150,
                              height: 7,
                              decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Here is the detection information",
                            style: TextStyle(fontSize: 20, height: 1.5),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.41,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.det.license_number,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          "License",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.41,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${num.parse((widget.det.accuracy * 100).toStringAsFixed(1))}%',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          "Accuracy",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.det.time,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      "Time",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "In the following section we can see two images, which are cropped from the camera frame when the car entered the camera zone.The first image is for the Detected Car, and the second image is for the Detected License.",
                            style: TextStyle(height: 1.6),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Gallery",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: MemoryImage(
                                                base64Decode((carData))),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 500,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: MemoryImage(
                                                base64Decode((plateData))),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    )
        /*Scaffold(
      appBar: AppBar(title: Text(widget.det.license_number)),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: MemoryImage(base64Decode((carData))),
                      height: 400,
                      width: 500,
                      fit: BoxFit.fitWidth,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  Center(
                    child: Image(
                      image: MemoryImage(base64Decode((plateData))),
                      height: 200,
                      width: 500,
                      fit: BoxFit.fitWidth,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Date: " + widget.det.time.substring(0, 10),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Time: " + widget.det.time.substring(12),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Detection: " + widget.det.license_number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Accuracy: " +
                          num.parse((widget.det.accuracy * 100)
                                  .toStringAsFixed(1))
                              .toString() +
                          '%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    )*/
        ;
  }
}
