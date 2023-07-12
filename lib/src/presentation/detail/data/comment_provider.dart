




import 'package:sajha_prakasan/src/presentation/detail/domain/service/comment_service.dart';

class CommentProvider{

  Future<String> addComment({required String token, required int userId, required int bookId, required String comment}) async{

    final response = await CommentService.postComment(token: token, bookId: bookId, userId: userId, comment: comment);

    if(response.success){
      return 'success';
    }else{
      return response.errors!;
    }
  }
}