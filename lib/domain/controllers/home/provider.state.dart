import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile/core/constant/image_network.dart';

class ImageNotifier extends StateNotifier<int> {
  Timer? _timer;

  ImageNotifier() : super(0) {
    _startImageRotation();
  }

  final List<String> imageUrls = [
    ImageNetwork.image1,
    ImageNetwork.image2,
    ImageNetwork.image3,
    ImageNetwork.image4,
    ImageNetwork.image5,
    ImageNetwork.image6,
    ImageNetwork.image7,
    ImageNetwork.image8,
    ImageNetwork.image9,
    ImageNetwork.image10,
  ].where((url) => url.isNotEmpty).toList(); // Filter out empty URLs

  void _startImageRotation() {
    if (imageUrls.isNotEmpty) {
      _timer = Timer.periodic(Duration(seconds: 60), (timer) {
        state = (state + 1) % imageUrls.length;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get currentImageUrl => imageUrls.isNotEmpty ? imageUrls[state] : '';
}
