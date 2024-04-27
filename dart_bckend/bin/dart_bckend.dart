// import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'server_handler.dart';

void main() async {
  ServeHandler server0 = ServeHandler();

  final server = await shelf_io.serve(server0.handler, 'localhost', 8080);

  print('Servidor iniciado em http://localhost:8080');
}
