import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/db_helper.dart';
import '../../core/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> list = [];
  int total = 0;
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    list = await DBHelper.getSubmissions();
    total = await DBHelper.count();
    var user = await DBHelper.getUser();
    name = user?["name"] ?? "";
    email = user?["email"] ?? "";
    setState(() {});
  }

  Widget row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                await DBHelper.logout();
                Get.offAllNamed(AppRoutes.login);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    row("Name", name),
                    row("Email", email),
                    row("Total Filled", total.toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Submission History",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (c, i) {
                  final item = list[i];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          row("Title", item["title"]),
                          row("Date", item["date"]),
                          row("Lat", item["lat"]),
                          row("Long", item["long"]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}