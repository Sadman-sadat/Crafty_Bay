import 'package:crafty_bay/data/models/wish_item_model.dart';

class WishListModel {
  String? msg;
  List<WishItemModel>? wishList;

  WishListModel({this.msg, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishList = <WishItemModel>[];
      json['data'].forEach((v) {
        wishList!.add(WishItemModel.fromJson(v));
      });
    }
  }
}

