
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/core/api.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/carousel.dart';


final carouselProvider = FutureProvider.autoDispose((ref) => CarouselProvider().getCarouselImg());


class CarouselProvider{

  Future<List<Carousel>> getCarouselImg() async{
    final dio = Dio();

    try{
      final response = await dio.post(Api.getCarouselImg);

      if(response.statusCode == 200 && response.data["returnMsg"]["success"] == true){
        final List<dynamic> result = response.data["imagesliderdetails"];
        final carouselImg = result.map((e) => Carousel.fromJson(e)).toList();
        return carouselImg;
      }else{
        return [];
      }
    }on DioError catch(err){
      throw err.message.toString();
    }
  }


}