import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final images = [
      'camera.png',
      'speaker.png',
      'mic.png',
      'maps.png',
      'telepon.png',
      'listrik.png',
      'pdam.png',
      'pulsa.png',
    ];
    return Container(
      margin: const EdgeInsets.only(left: 37, top: 30),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xffE6E9ED)),
        ),
        //
        child: TextButton(
          onPressed: () {
            _navigateToPage(images[index]);
          },
          child: Image.asset('assets/images/${images[index]}'),
        ),
      ),
    );
  }
  void _navigateToPage(String imageName) {
    switch (imageName) {
      case 'camera.png':
        Get.toNamed('/camera');
        break;
      case 'speaker.png':
        Get.toNamed('/speaker');
        break;
      case 'mic.png':
        Get.toNamed('/mic');
        break;
      case 'maps.png':
        Get.toNamed('/maps');
        break;
      case 'telepon.png':
        Get.toNamed('/telepon');
        break;
      case 'listrik.png':
        Get.toNamed('/listrik');
        break;
      case 'pdam.png':
        Get.toNamed('/pdam');
        break;
      case 'pulsa.png':
        Get.toNamed('/pulsa');
        break;
      default:
        Get.snackbar("Error", "Halaman tidak ditemukan",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
