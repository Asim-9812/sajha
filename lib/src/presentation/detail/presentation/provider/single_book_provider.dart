



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajha_prakasan/src/presentation/detail/data/book_detail_provider.dart';

final singleBookProvider = FutureProvider.autoDispose.family((ref, int id) => BookProvider().fetchBookDetails(id));
