import 'package:crafty_bay/data/models/slider_data_model.dart';

class SliderListModel {
  String? msg;
  List<Category>? sliderList;

  SliderListModel({this.msg, this.sliderList});

  SliderListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      sliderList = <Category>[];
      json['data'].forEach((v) {
        sliderList!.add(Category.fromJson(v));
      });
    }
  }
}
