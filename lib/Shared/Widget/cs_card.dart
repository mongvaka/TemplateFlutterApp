import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Base/images_collection_model.dart';
import 'package:ice_fac_mobile/Shared/Base/keywords_model.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_button.dart';

class CsCard extends StatefulWidget {
  final String headerText;
  final String headerHint;
  final String titleText;
  final String titleHint;
  final List<CsKeywordsModel> keywords;
  final String description;
  final String imageLeader;
  final String imageBackground;
  final List<ImageCollectionModel> collectionList;
  final List<Widget> customActions;
  List<String> imageUrl = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQphqmpunOcktIYDIfRzoWH76GnevhjUbgkw-KYFu2mT0uIavZDs4V_Ekyl_c8UTE95wX4&usqp=CAU',
    'https://thumbs.dreamstime.com/b/cosmos-beauty-deep-space-elements-image-furnished-nasa-science-fiction-art-102581846.jpg',
    'https://i2.wp.com/www.shorteng.com/wp-content/uploads/2015/12/photo.jpg?resize=470%2C313',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQphqmpunOcktIYDIfRzoWH76GnevhjUbgkw-KYFu2mT0uIavZDs4V_Ekyl_c8UTE95wX4&usqp=CAU',
    'https://thumbs.dreamstime.com/b/cosmos-beauty-deep-space-elements-image-furnished-nasa-science-fiction-art-102581846.jpg',
    'https://i2.wp.com/www.shorteng.com/wp-content/uploads/2015/12/photo.jpg?resize=470%2C313',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQphqmpunOcktIYDIfRzoWH76GnevhjUbgkw-KYFu2mT0uIavZDs4V_Ekyl_c8UTE95wX4&usqp=CAU',
    'https://thumbs.dreamstime.com/b/cosmos-beauty-deep-space-elements-image-furnished-nasa-science-fiction-art-102581846.jpg',
    'https://i2.wp.com/www.shorteng.com/wp-content/uploads/2015/12/photo.jpg?resize=470%2C313',
  ];
  final dynamic model;
  final dynamic service;

  CsCard(
      {this.headerText,
      this.headerHint,
      this.titleText,
      this.titleHint,
      this.keywords,
      this.description,
      this.imageLeader,
      this.imageBackground,
      this.collectionList,
      this.customActions,
      this.model,
      this.service});

  @override
  _CsCardState createState() => _CsCardState();
}

class _CsCardState extends State<CsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    widget.imageLeader == null
                        ? SizedBox()
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              widget.imageLeader,
                            ),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        widget.headerText == null
                            ? SizedBox()
                            : Text(
                                widget.headerText,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                        widget.titleText == null
                            ? SizedBox()
                            : Text(
                                widget.titleText,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ...getKeywordWidget(widget.keywords),
          Container(
            width: MediaQuery.of(context).size.width,
            child: new Text(
              'you could try wrapping image.network in a a container with infinite dimensions which takes the available size of its parent (meaning if you drop this container in lower half of screen it will fill the lower half of screen if you put this directly as the body of scaffold it will take the full screen)',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 150,
            child: ListView.builder(
                itemCount: widget.imageUrl.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(2),
                      child: Center(
                        child: Image.network(
                          widget.imageUrl[index],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),
                      ),
                      color: Colors.green,
                    )),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Icon(Icons.visibility, color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'VIEW',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('DEL', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(flex: 1, child: SizedBox())
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getKeywordWidget(List<CsKeywordsModel> keyList) {
    List<Widget> widgetList = [];
    keyList.forEach((element) {
      widgetList.add(Container(
        width: MediaQuery.of(context).size.width,
        child: new Text(
          element.text,
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ));
    });

    return widgetList;
  }
}
