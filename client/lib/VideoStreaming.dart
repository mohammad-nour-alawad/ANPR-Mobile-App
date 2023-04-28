import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:client/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:udp/udp.dart';
import 'package:android_multicast_lock/android_multicast_lock.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({Key? key}) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  final items = ['5000', '5001', '5002', '5003', '5004'];
  int portNum = 5000;
  bool connected = false;
  late StreamController _controller = StreamController();
  final multicastLock = MulticastLock();
  var sock;
  void _connect(int? port) async {
    print("port " + port.toString());
    var multicastEndpoint = Endpoint.multicast(InternetAddress('224.1.1.1'),
        port: Port(port ?? 5004));

    _controller = StreamController();
    sock = await UDP.bind(multicastEndpoint);
    sock.asStream().listen((datagram) {
      if (datagram != null) {
        var stream = utf8.decode(datagram.data);
        //print(stream);
        _controller.add(stream);
      }
    });
    setState(() {
      connected = true;
    });
  }

  void _disconnect() {
    sock.close();
    multicastLock.release();
    connected = false;
  }

  @override
  void initState() {
    super.initState();
    multicastLock.acquire();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: portNum.toString(),
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      if (connected) {
                        _disconnect();
                      }
                      setState(() {
                        portNum = int.parse(value ?? "5000");
                      });
                      print(portNum);
                      _connect(portNum);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomStreamBuilder(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
}
