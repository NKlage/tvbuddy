import 'dart:io';

class TestJsonResponses {
  Future<String> getJson(String jsonResponseFile) async {
    final file = File(jsonResponseFile);
    return file.readAsString();
  }
}
