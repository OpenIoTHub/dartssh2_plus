import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2_plus/dartssh2.dart';

void main(List<String> args) async {
  final client = SSHClient(
    await SSHSocket.connect('localhost', 22),
    username: 'root',
    onPasswordRequest: () {
      stdout.write('Password: ');
      stdin.echoMode = false;
      return stdin.readLineSync() ?? exit(1);
    },
  );

  final session = await client.execute('cat > file.txt');
  await File('local_file.txt').openRead().cast<Uint8List>().pipe(session.stdin);

  await session.done;
  print('done');

  client.close();
  await client.done;
}
