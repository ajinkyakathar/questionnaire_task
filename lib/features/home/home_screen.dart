import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> list = const [
    {"title": "English Grammar", "desc": "Basic grammar MCQ"},
    {"title": "Science Quiz", "desc": "General science questions"},
    {"title": "History Quiz", "desc": "World history MCQ"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questionnaires"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.profile),
              icon: const Icon(Icons.person))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: list.length,
        itemBuilder: (c, i) {
          return Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(list[i]["title"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(list[i]["desc"]!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Get.toNamed(
                  AppRoutes.questionnaire,
                  arguments: list[i]["title"]),
            ),
          );
        },
      ),
    );
  }
}