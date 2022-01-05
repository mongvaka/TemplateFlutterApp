import 'dart:convert';

import 'package:http/http.dart';
import 'package:ice_fac_mobile/post_model.dart';

class HttpService {
  final String POST_URL = "http://localhost:5001/api";
  Future<List<Post>> getPost() async {
    Response res = await get(Uri.parse(POST_URL));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();
      return posts;
    } else {
      print("Can't get posts");
    }
  }
}
