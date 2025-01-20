import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'mitems.dart';

class ProdukEdit extends StatefulWidget {
  final ItemModel sw;

  ProdukEdit({required this.sw});

  @override
  State<StatefulWidget> createState() => ProdukEditState();
}

class ProdukEditState extends State<ProdukEdit> {
  final formkey = GlobalKey<FormState>();
  late TextEditingController namapelangganController,
      durasiController,
      nomorbilingController;



  Future editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.Edit),
      body: {
        "id": widget.sw.id.toString(),
        "nama_pelanggan": namapelangganController.text,
        "durasi": durasiController.text,
        "nomor_biling": nomorbilingController.text,
      },
    );
  }

  void showMessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      showMessage("Perubahan data berhasil", Colors.green);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } else {
      showMessage("Gagal memperbarui data", Colors.red);
    }
  }



  @override
  void initState() {
    namapelangganController = TextEditingController(text: widget.sw.nama_pelanggan);
    durasiController = TextEditingController(text: widget.sw.durasi.toString());
    nomorbilingController = TextEditingController(text: widget.sw.nomor_biling.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Pelanggan"),
        centerTitle: true,
        backgroundColor: Colors.lime,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () => _onConfirm(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lime,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          icon: Icon(Icons.save, color: Colors.white),
          label: Text("Update",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: namapelangganController,
                decoration: InputDecoration(
                  labelText: "Nama Pelanggan",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: durasiController,
                decoration: InputDecoration(
                  labelText: "Durasi",
                  prefixIcon: Icon(Icons.timer),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nomorbilingController,
                decoration: InputDecoration(
                  labelText: "Nomor Biling",
                  prefixIcon: Icon(Icons.card_membership),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
