import 'package:favorite/entity/picture.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key key,
    this.itemIndex,
    this.picture,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final Picture picture;
  final Function press;

  @override
  Widget build(BuildContext context) {
    AlbumListModel model = Provider.of<AlbumListModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // カード背景
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven
                    ? Colors.orangeAccent[200]
                    : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // 写真
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160,
                width: 190,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    picture.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // 写真コメント
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 136,
                width: size.width - 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/calendar.svg",
                                height: 18,
                                width: 18,
                              ),
                              Text(
                                DateFormat('yyyy/MM/dd')
                                    .format(picture.createdAt.toDate())
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/camera.svg",
                                height: 18,
                                width: 18,
                              ),
                              Text(
                                picture.title,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 4,
                      ),
                      decoration: BoxDecoration(
                        color: model.setCategoryColor(model.selectAlbumNo),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        model.selectAlbumNo == 0
                            ? '新着'
                            : 'アルバム' + model.selectAlbumNo.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
