


import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:sajha_prakasan/src/core/api.dart';


class PDFService{
  static Future<String> getBookPdf(int bookEditionID) async{
    final dio = Dio();

    final box = Hive.box<String>('tokenBox');
    final accessToken = box.get('accessToken');
    try{

      final response = await dio.post('${Api.getBookPdf}/$bookEditionID',
          options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
              }
          ),
        queryParameters: {
        "bookeditionid": bookEditionID
        }
      );

      if(response.statusCode == 200 && response.data["success"] == true){

        final pdfURI = response.data["payload"];
        final pdf = "${Api.baseUrl}$pdfURI";
        return pdf;
      }else{
        return response.data["errors"];
      }
    }on DioError catch(err){
      return err.message!;
    }
  }
}