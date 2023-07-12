import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sajha_prakasan/src/presentation/common/app_bar.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/domain/model/book_model.dart';
import 'package:sajha_prakasan/src/presentation/dashboard/search/domain/service/search_service.dart';
import 'package:sajha_prakasan/src/presentation/detail/presentation/pages/new_detail_page.dart';

import 'package:sajha_prakasan/src/core/resources/color_manager.dart';
import 'package:sajha_prakasan/src/core/resources/style_manager.dart';



class SearchBookPage extends ConsumerStatefulWidget {
  const SearchBookPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends ConsumerState<SearchBookPage> {
  late List<BookInfo> books;
  String query = '';

  @override
  void initState() {
    super.initState();
    books = [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(titleText: 'Search Books', hasBoxShadow: true, hasArrow: true,),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 30.h,),
                        buildSearch(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: books.isEmpty ? const Text('Search by book name') : ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return buildBook(book);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Title or Author Name',
    onChanged: searchBook,
  );

  Widget buildBook(BookInfo book) => ListTile(
    onTap: () {
      Get.to(() => BookDetailPage(bookId: book.bookID));
    },
    leading: Image.network(
        book.imagePath,
      fit: BoxFit.cover,
      height: 60.h,
      width: 40.w,
    ),
    title: Text(book.bookNameEnglish, style: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),),
    subtitle: Text(book.genres[0].genreEnglish, style: getRegularStyle(color: ColorManager.blackOpacity70, fontSize: 14.sp),),
  );


  void searchBook(String query) async {
    final bookResult = await SearchService().searchBooks(query);

    final books = bookResult.where((book) {
      final titleLower = book.bookNameEnglish.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.books = books;
    });
  }

}



class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  const SearchWidget({
    Key? key, required this.text, required this.onChanged, required this.hintText,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.inputGreen,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
              color: ColorManager.primary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 21.w),
        suffixIcon: widget.text.isNotEmpty ? GestureDetector(
          child: Icon(Icons.close, color: ColorManager.iconGrey),
          onTap: () {
            controller.clear();
            widget.onChanged('');
            FocusScope.of(context).requestFocus(FocusNode());
            },
        ) : Icon(CupertinoIcons.search, color: ColorManager.iconGrey,),
        hintText: widget.hintText,
        hintStyle: getRegularStyle(
            color: ColorManager.textGrey, fontSize: 16),
      ),
      cursorColor: ColorManager.brightGreen,
      onChanged: widget.onChanged,
    );
  }
}