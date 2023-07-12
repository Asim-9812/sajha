import 'package:flutter_riverpod/flutter_riverpod.dart';



final loadingProvider = StateNotifierProvider.autoDispose<LoadingProvider, bool>((ref) => LoadingProvider(false));

class LoadingProvider extends StateNotifier<bool>{
  LoadingProvider(super.state);
  void toggle(){
    state = !state;
  }
}