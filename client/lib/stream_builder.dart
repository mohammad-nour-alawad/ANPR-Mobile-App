import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';

class CustomStreamBuilder extends StatefulWidget {
  const CustomStreamBuilder({Key? key, required this.controller})
      : super(key: key);

  final StreamController controller;
  @override
  State<CustomStreamBuilder> createState() => _CustomStreamBuilder();
}

class _CustomStreamBuilder extends State<CustomStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.controller.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const Center(
            child: Text("Connection Closed !"),
          );
        }
        //? Working for single frames
        return Image.memory(
          base64Decode(
            (snapshot.data.toString()),
          ),
          gaplessPlayback: true,
        );
      },
    );
  }
}
