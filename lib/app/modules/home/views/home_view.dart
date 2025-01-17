import 'package:dompetdhuafaconceptmodul4/app/modules/home/views/widget/floating_button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widget/appbar_widget.dart';
import 'widget/grid_widget.dart';
import 'widget/image_widget.dart';
import 'widget/news.dart';
import 'widget/wallet_card_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: const AppbarWidget(),
      body: Stack(
        children: [
          ImageWidget(),
          const GridWidget(),
          const WalletCardWidget(),
          NewsWidget(),
          FloatingButtonWidget(),
        ],
      ),


      // Menampilkan Snackbar jika status koneksi berubah
      // floatingActionButton: Obx(() {
      //   if (controller.isConnected.value) {
      //     return FloatingActionButton(
      //       onPressed: () {},
      //       child: const Icon(Icons.check),
      //     );
      //   } else {
      //     return FloatingActionButton(
      //       onPressed: () {
      //         Get.snackbar(
      //           "Tidak ada koneksi",
      //           "Periksa koneksi internet Anda",
      //           snackPosition: SnackPosition.BOTTOM,
      //           backgroundColor: Colors.red,
      //           colorText: Colors.white,
      //         );
      //       },
      //       child: const Icon(Icons.error),
      //     );
      //   }
      // }),
    );
  }

}
