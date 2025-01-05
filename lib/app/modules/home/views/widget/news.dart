import 'package:dompetdhuafaconceptmodul4/app/modules/home/views/widget/news_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class NewsWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 480), // Menyesuaikan margin agar tidak tertutup oleh widget lain
      child: Column(
        children: [
          // Judul News
          Text(
            'News',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),

          // Menggunakan Obx untuk memantau perubahan pada nilai isLoading
          Obx(() {
            if (homeController.isLoading.value) {
              // Menampilkan indikator loading saat data sedang dimuat
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
              );
            } else {
              // Menampilkan daftar artikel setelah selesai dimuat
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.articles.length, // Jumlah artikel
                  itemBuilder: (context, index) {
                    // Menggunakan widget NewsItemWidget untuk menampilkan tiap artikel
                    return NewsItemWidget(
                      article: homeController.articles[index],
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
