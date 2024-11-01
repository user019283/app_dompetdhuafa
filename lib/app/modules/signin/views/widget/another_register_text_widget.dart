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
      // width: 219,
      // height: 15,
      margin: const EdgeInsets.only(top: 718, left: 100),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 17),
            child: const Text(
              'Belum punya akun?',
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff242B42)),
            ),
          ),
          Container(
            // height: 100,
            margin: const EdgeInsets.only(left: 100, bottom: 100),
            child: TextButton(

              onPressed: () {
                Get.to(const RegisterView());
              },
              child: const Text(
                ' Daftar dulu yuk',
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
          )
        ],
      ),
    );
  }
}
