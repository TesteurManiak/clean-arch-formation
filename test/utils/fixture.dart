import 'dart:io' show File;

import 'dart:typed_data';

String fixture(String name) => File('test/resources/$name').readAsStringSync();

Future<Uint8List> fixtureAsBytes(String name) =>
    File('test/resources/$name').readAsBytes();
