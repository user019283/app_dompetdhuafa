import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopupWidget extends StatelessWidget {
  const TopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Card(
      margin: const EdgeInsets.only(left: 100, top: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xff128848)),
      ),
      child: SizedBox(
        height: 36,
        width: 86,
        child: TextButton(
          onPressed: () {
            final TextEditingController saldoController = TextEditingController();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Isi Saldo'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Masukkan jumlah saldo yang ingin di-top up:'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: saldoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Jumlah saldo',
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog jika batal
                      },
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () async {
                        String jumlahSaldo = saldoController.text;

                        if (jumlahSaldo.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Masukkan jumlah saldo yang valid'),
                            ),
                          );
                          return;
                        }

                        int jumlahSaldoInt = int.parse(jumlahSaldo);

                        // Mendapatkan userId dari Firebase Authentication
                        User? user = auth.currentUser;
                        if (user == null) {
                          // Jika user belum login
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Anda harus login terlebih dahulu'),
                            ),
                          );
                          return;
                        }
                        String userId = user.uid;

                        // Tampilkan dialog loading
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(), // Animasi loading
                            );
                          },
                        );

                        try {
                          // Cek apakah data user sudah ada di Firestore
                          DocumentReference userRef = firestore.collection('topup').doc(userId);
                          DocumentSnapshot userSnapshot = await userRef.get();

                          if (userSnapshot.exists) {
                            // Jika data user sudah ada, tambahkan saldo baru
                            int currentSaldo = userSnapshot.get('jumlah_saldo');
                            await userRef.update({
                              'jumlah_saldo': currentSaldo + jumlahSaldoInt,
                              'last_topup': FieldValue.serverTimestamp(),
                            });
                          } else {
                            // Jika data user belum ada, buat entri baru
                            await userRef.set({
                              'user_id': userId,
                              'jumlah_saldo': jumlahSaldoInt,
                              'last_topup': FieldValue.serverTimestamp(),
                            });
                          }

                          // Tutup loading dan tampilkan notifikasi berhasil
                          Navigator.of(context).pop(); // Tutup dialog loading
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Top-up berhasil!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          // Tutup loading dan tampilkan notifikasi gagal
                          Navigator.of(context).pop(); // Tutup dialog loading
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Top-up gagal: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }

                        Navigator.of(context).pop(); // Tutup dialog setelah input
                      },
                      child: const Text('Top-Up'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Center(
            child: Text(
              'Isi Saldo',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff128848),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
