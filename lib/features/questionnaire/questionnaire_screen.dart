import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/db_helper.dart';
import '../../core/routes.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {

  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() {
    String title = Get.arguments ?? "";

    if (title == "English Grammar") {
      questions = [
        q("Choose correct sentence",
            ["He go school", "He goes to school", "He going school", "He gone"]),
        q("Synonym of Happy",
            ["Sad", "Joyful", "Angry", "Weak"]),
        q("Antonym of Big",
            ["Large", "Huge", "Small", "Tall"]),
        q("Plural of Child",
            ["Childs", "Children", "Childes", "Childer"]),
        q("Verb in sentence",
            ["Ram", "is", "boy", "good"]),
      ];
    }

    else if (title == "Science Quiz") {
      questions = [
        q("Water formula",
            ["CO2", "H2O", "NaCl", "O2"]),
        q("Sun is a",
            ["Planet", "Star", "Moon", "Comet"]),
        q("Gas we breathe",
            ["Oxygen", "Hydrogen", "Nitrogen", "CO2"]),
        q("Earth shape",
            ["Flat", "Round", "Triangle", "Square"]),
        q("Human heart chambers",
            ["2", "3", "4", "5"]),
      ];
    }

    else {
      questions = [
        q("India independence year",
            ["1945", "1947", "1950", "1930"]),
        q("First President India",
            ["Gandhi", "Nehru", "Rajendra Prasad", "Modi"]),
        q("World war 2 end",
            ["1945", "1939", "1918", "1960"]),
        q("Taj Mahal built by",
            ["Akbar", "Shah Jahan", "Babar", "Aurangzeb"]),
        q("Capital of India",
            ["Mumbai", "Delhi", "Pune", "Chennai"]),
      ];
    }

    setState(() {});
  }

  Map<String, dynamic> q(String text, List<String> opt) {
    return {"q": text, "opt": opt, "sel": null};
  }

  void submit() async {
    for (var item in questions) {
      if (item["sel"] == null) {
        Get.snackbar("Error", "Answer all questions");
        return;
      }
    }

    await DBHelper.saveSubmission(Get.arguments ?? "Quiz");
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments ?? "Quiz";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {

          if (index == questions.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: submit,
                child: const Text("Submit"),
              ),
            );
          }

          final item = questions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    item["q"].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  ...List.generate(4, (i) {
                    return RadioListTile<int>(
                      value: i,
                      groupValue: item["sel"],
                      title: Text(item["opt"][i]),
                      onChanged: (val) {
                        setState(() {
                          item["sel"] = val;
                        });
                      },
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}