import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/package/localization/app_translations.dart';

class MoreDetailListItem extends StatelessWidget {
  MoreDetailListItem(
      {this.imageUrl,
      this.title,
      this.subtitle,
      this.onFavoriteButtonPress,
      this.onDownloadButtonPress});

  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onFavoriteButtonPress;
  final VoidCallback onDownloadButtonPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.colorAppTabBar,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        children: <Widget>[
          ListTile(
            leading: (Image.network(imageUrl)),
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: Colors.white60),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.grey,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Divider(color: Colors.grey[700]),
          Card(
            color: AppColors.colorListItemCard,
            margin: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  trailing: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppTranslations.of(context).text("morepopup_like"),
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: onFavoriteButtonPress,
                ),
                Divider(
                  color: Colors.grey[700],
                ),
                ListTile(
                  trailing: Icon(
                    Icons.file_download,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppTranslations.of(context).text("morepopup_download"),
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: onDownloadButtonPress,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
