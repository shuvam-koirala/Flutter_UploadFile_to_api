import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
//import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class ApiManager {
  // Future<List<FilterModel>> getFilter() async {
  //   List<FilterModel> filterModel = null;
  //   final String url = "http://165.227.203.240/api/filter/";
  //   var client = http.Client();
  //   try {
  //     var response = await client
  //         .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

  //     if (response.statusCode == 200) {
  //       var jsonString = response.body;
  //       //var jsonMap = json.decode(jsonString);
  //       filterModel = filterModelFromJson(jsonString);
  //       return filterModel;
  //     }
  //   } catch (Exception) {
  //     return filterModel;
  //   }
  //   return filterModel;
  // }

  // void uploadFile(File filePath) async {
  //   final String url = "http://165.227.203.240/api/filter/";
  //   print("file path:${filePath.path}");
  //   //try {
  //   String fileName = filePath.path.split("/").last;
  //   print("File base name: $fileName");
  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(filePath.path,
  //         filename: fileName, contentType: MediaType("file", "jpg")),
  //   });
  //   Response response = await Dio().post(url,
  //       data: formData,
  //       queryParameters: {"action": "FILTER"},
  //       options: Options(
  //           method: "POST",
  //           contentType: "multipart/form-data",
  //           headers: {
  //             "Vary": "Accept",
  //             "Authorization": "Bearer accesstoken",
  //             "Content-Type": "application/json"
  //           }));
  //   print("status code :${response.statusCode}");
  //   //print("request info :${response.request}");
  //   print("response headers: ${response.headers}");
  //   if (response.statusCode == 200)
  //     print("File upload response:${response.data}");
  //   else {
  //     print("error message:${response.data}");
  //     print("error message:${response.statusMessage}");
  //   }
  //   // } catch (e) {
  //   //   print("Exception caught: ${e.toString()}");
  //   // }
  // }

  void uploadFile(File filePath) async {
    print("file path:${filePath.path}");
    String fileName = filePath.path.split("/").last;
    final bytes = await compute(compress, filePath.readAsBytesSync());

    // String token = await storage.FlutterSecureStorage().read(key: "token");
    final String url = "http://165.227.203.240/api/filter/";
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields["action"] = "FILTER_MOTIVATION"
      ..files.add(await http.MultipartFile.fromBytes("file", bytes,
          filename: fileName));
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("status code:${response.body}");
    print("status code:${response.headers}");
    print("status code:${response.reasonPhrase}");
    print("status code:${response.statusCode}");

    http.MultipartFile.fromPath("img", filePath.path,
        contentType: MediaType("image", "jpg"));
  }
}

List<int> compress(List<int> bytes) {
  var image = img.decodeImage(bytes);
  var resize = img.copyResize(image, width: 480, height: 480);
  return img.encodeJpg(resize);
}

//http://165.227.203.240/api/filter/
