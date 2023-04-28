//import 'dart:convert';
//import 'dart:typed_data';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  // Log into database
  final db = await Db.create(
      'mongodb+srv://anpr:anpranpr@lpr.et0guo9.mongodb.net/anpr_results?retryWrites=true&w=majority');

  await db.open(secure: true);
  var coll = db.collection('detection_collection');
  var usersColl = db.collection('users');
  var imageColl = db.collection('images');
  var carColl = db.collection('cars_collection');

  //var bucket = GridFS(db);

  //var ret = await bucket.chunks.find(where.sortBy('_id')).first;
  //var img = MemoryImage(base64Decode(ret['data']));

  //var imagepath = Io.File("server/lib/1.png");
  //final bytes = imagepath.readAsBytesSync();
  //String base64Encode(List<int> bytes) => base64.encode(bytes);
  //Uint8List base64Decode(String source) => base64.decode(source);

  //var ret = await bucket.chunks.find(where.sortBy('_id')).first;

  //var ret = await db.collection("images").find(where.sortBy('_id')).first;
  //var img64 = base64Decode(ret['data']);
  //print(ret['data'].substring(0, 100));

  //final decodedBytes = base64Decode(img64);
  //var file = Io.File('server/lib/decommmmmm.png');
  //file.writeAsBytesSync(img64);
  //print(await usersColl.find(where.eq('username', "anpr")).first);

  // Create server
  const port = 8081;
  final serv = Sevr();

  final corsPaths = ['/', '/:id', '/getimages/:filename'];

  for (var route in corsPaths) {
    serv.options(route, [
      (req, res) {
        setCors(req, res);
        return res.status(200);
      }
    ]);
  }

  serv.get('/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final detections =
          await coll.find(where.sortBy('_id', descending: true)).toList();
      return res.status(200).json({'detections': detections});
    }
  ]);

  serv.get('/:pageNum', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final detections = await coll
          .find(where.sortBy('_id'))
          .skip(int.parse(req.params['pageNum']) * 10)
          .take(10)
          .toList();
      return res.status(200).json({'detections': detections});
    }
  ]);

  serv.post('/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      return res.status(200).json(
            await usersColl.findOne(where
                .eq('username', req.body['username'])
                .eq('password', req.body['password'])),
          );
    }
  ]);
  serv.get('/getimages/:filename', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final car = await carColl
          .find(where.eq('filename', req.params['filename']))
          .first;
      final plate = await imageColl
          .find(where.eq('filename', req.params['filename']))
          .first;
      return res.status(200).json({
        'images': {'car': car, 'plate': plate}
      });
    }
  ]);

  // Listen for connections
  serv.listen(port, address: '192.168.137.1', callback: () {
    print('Server listening on port: $port');
  });
}

void setCors(ServRequest req, ServResponse res) {
  res.response.headers.add('Access-Control-Allow-Origin', '*');
  res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
  res.response.headers
      .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
}
