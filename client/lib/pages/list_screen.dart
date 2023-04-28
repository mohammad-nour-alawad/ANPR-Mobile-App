import 'package:client/pages/detection_details_screen.dart';
import 'package:client/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:client/api.dart';

class DetectionListScreen extends StatefulWidget {
  DetectionListScreen({Key? key}) : super(key: key);

  final Api api = Api();
  @override
  _DetectionListScreen createState() => _DetectionListScreen();
}

class _DetectionListScreen extends State<DetectionListScreen> {
  List detections = [];
  List filterdDetections = [];
  List twoStepsfilterdDetections = [];

  String query = '';
  int currentPage = 0;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 1, 1),
    end: DateTime(2030, 1, 1),
  );
  //Map<String, String> imgs = {};
  bool loading = true;

  @override
  void initState() {
    _loadDetections();
    super.initState();
  }

  void _loadDetections([bool showSpinner = false]) async {
    if (showSpinner) {
      setState(() {
        loading = true;
      });
    }
    widget.api.getDetections().then((value) {
      setState(() {
        detections = value;
        filterdDetections = value;
        loading = false;
      });
    });
    /*
    widget.api.getImages().then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          imgs[filterdDetections[i].filename] = value[i].data;
        }
        loading = false;
      });
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
        appBar: AppBar(
          title: const Text("ALPR Dashboard: Detections"),
        ),
        body: Column(
          children: [
            buildSearch(),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: pickDateRange,
                      child: Text('${start.year}/${start.month}/${start.day}'),
                    ),
                  ),
                  const Text(
                    " to ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: pickDateRange,
                      child: Text('${end.year}/${end.month}/${end.day}'),
                    ),
                  ),
                ],
              ),
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: filterdDetections.length,
                        itemBuilder: (context, index) {
                          var det = filterdDetections[index];
                          //var img = imgs[det.filename];
                          return Card(
                            child: ListTile(
                              leading: Text(det.camLocation),
                              title: Text(
                                'Plate: ${det.license_number}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: Text(det.time),
                              ),
                              trailing: Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "Accuracy: " +
                                    num.parse((det.accuracy * 100)
                                            .toStringAsFixed(1))
                                        .toString() +
                                    '%',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetectionDetailsScreen(
                                            det: det, filename: det.filename),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0.1),
          child: FloatingActionButton(
            onPressed: () {
              _loadDetections(true);
            },
            tooltip: "Refresh",
            child: const Icon(Icons.refresh),
          ),
        ));
  }

  Future pickDateRange() async {
    DateTimeRange? newDateTime = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialDateRange: dateRange,
    );

    if (newDateTime == null) {
      return;
    } else {
      setState(() {
        dateRange = newDateTime;
      });
      searchDetection(query);
    }
  }

  Widget buildSearch() {
    return SearchWidget(
        text: query,
        onChanged: searchDetection,
        hintText: 'Search with plate number');
  }

  void searchDetection(String query) {
    final filterdDetections = detections.where((e) {
      final plateNumber = e.license_number;
      final searchLower = query; //.toLowerCase();
      String date = e.time;

      final detectionDate = DateTime(int.parse(date.substring(6, 10)),
          int.parse(date.substring(3, 5)), int.parse(date.substring(0, 2)));

      bool notOk = detectionDate.compareTo(dateRange.start) < 0 ||
          detectionDate.compareTo(dateRange.end) > 0;

      return plateNumber.contains(searchLower) && (!notOk);
    }).toList();

    setState(() {
      this.query = query;
      this.filterdDetections = filterdDetections;
    });
  }

/*
  popUp() {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 320,
              ),
            ),
          );
        });
  }
  */
}
