

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/service/book_list_service.dart';

final bookListProvider = FutureProvider.family.autoDispose((ref, int id) => BookListService().getSubscribedBooks(id));
