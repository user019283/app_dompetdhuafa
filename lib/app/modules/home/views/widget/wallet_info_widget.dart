import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import NumberFormat

class WalletInfoWidget extends StatelessWidget {
  const WalletInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'id', // Lokasi Indonesia
      symbol: 'Rp', // Simbol mata uang
      decimalDigits: 0, // Tidak ada digit desimal
    );

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Jika user belum login, tampilkan saldo 0
          return Text(
            currencyFormat.format(0), // Format Rp0
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
            ),
          );
        }

        User? user = snapshot.data;
        if (user == null) {
          return Text(
            currencyFormat.format(0), // Format Rp0
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
            ),
          );
        }

        return StreamBuilder<DocumentSnapshot>(
          stream: firestore.collection('topup').doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Loading...',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              // Jika belum ada data saldo, tampilkan Rp0
              return Text(
                currencyFormat.format(0), // Format Rp0
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              );
            }

            // Ambil data saldo dari Firestore
            var saldo = snapshot.data!['jumlah_saldo'] ?? 0;

            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    currencyFormat.format(saldo), // Format saldo sebagai Rupiah
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 30),
                  child: const Text(
                    'Dompet Donasimu',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7E8CA0),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
