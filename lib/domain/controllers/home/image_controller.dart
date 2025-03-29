import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider.state.dart';

final changeImageByTime = StateNotifierProvider<ImageNotifier, int>((ref){
  return ImageNotifier();

});