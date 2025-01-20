import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail.dart';
import 'package:notes/pages/tambah.dart';
import 'api.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'mitems.dart';

class ProdukPage extends StatefulWidget {
  @override
  ProdukPage({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return ProdukPageState();
  }
}

class ProdukPageState extends State<ProdukPage> {
  late Future<List<ItemModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ItemModel>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.List));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ItemModel> sw = items.map<ItemModel>((json) {
      return ItemModel.fromJson(json);
    }).toList();
    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.book,
              color: Colors.white,
            ),
            SizedBox(width: 8), // J
            Text(
              "List Biling Warnet",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),

        centerTitle: true,
        backgroundColor: Colors.lime,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: FutureBuilder<List<ItemModel>>(
          future: sw,
          builder:
              (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found'));
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[300],
              ),
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.monitor, color: Colors.lime),
                    ),
                    title: Center(
                      child: Text(
                        data.nama_pelanggan,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Durasi: ${data.durasi} Jam",
                          style:
                          TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.lime),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProdukDetail(sw: data)),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lime,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProdukTambah()),
          );
        },
        label: const Text(
          "Tambah Catatan",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),

    );
  }
}
