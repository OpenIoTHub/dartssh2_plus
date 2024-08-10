import 'package:dartssh2_plus/dartssh2.dart';

void main(List<String> args) async {
  final client = SSHClient(
    await SSHSocket.connect('<ip>', 22),
    username: '...',
    onPasswordRequest: () => '...',
  );

  final httpClient = SSHHttpClient(client);
  final request = httpClient.get(Uri.parse('http://httpbin.org/get'));
  final response = await request.close();
  print(response.body);

  client.close();
}
