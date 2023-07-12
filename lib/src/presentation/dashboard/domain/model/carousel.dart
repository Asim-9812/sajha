import 'package:sajha_prakasan/src/core/api.dart';

class Carousel {
  int? sliderID;
  String? sliderName;
  String? imageUrl;
  bool? status;
  String? validFrom;
  String? validTo;

  Carousel(
      {this.sliderID,
        this.sliderName,
        this.imageUrl,
        this.status,
        this.validFrom,
        this.validTo,
      });

  Carousel.fromJson(Map<String, dynamic> json) {
    sliderID = json['sliderID'];
    sliderName = json['slider_Name'];
    imageUrl = '${Api.baseUrl}/${json['image_Url']}';
    status = json['status'];
    validFrom = json['validFrom'];
    validTo = json['validTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sliderID'] = sliderID;
    data['slider_Name'] = sliderName;
    data['image_Url'] = imageUrl;
    data['status'] = status;
    data['validFrom'] = validFrom;
    data['validTo'] = validTo;
    return data;
  }
}
