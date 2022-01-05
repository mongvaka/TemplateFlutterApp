import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/http_service.dart';
import 'package:ice_fac_mobile/post_model.dart';

class PostPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final HttpService httpService = HttpService();
    return Scaffold(
      appBar: AppBar(
        title: Text('PostApp'),
      ),
      body: FutureBuilder(
        future: httpService.getPost(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
          if(snapshot.hasData){
             List<Post> posts = snapshot.data;
             return ListView(
               children: posts.map((Post post)=> ListTile(title: Text(post.title),
               )).toList(),
             );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

}