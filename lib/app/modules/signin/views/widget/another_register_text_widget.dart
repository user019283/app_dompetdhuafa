import 'package:dompetdhuafaconceptmodul4/app/modules/register/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnotherRegisterTextWidget extends StatelessWidget {
  const AnotherRegisterTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 718),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Belum punya akun? ',
            style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff242B42)),
          ),
          TextButton(
            onPressed: () {
              Get.to(const RegisterView());
            },
            child: const Text(
              ' DAFTAR DULU YUK',
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff00A44F),
            ),
          ),
        ],
      ),
    );
  }
}
