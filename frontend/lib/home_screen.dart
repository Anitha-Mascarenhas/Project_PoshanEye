import 'package:flutter/material.dart';
import 'model_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final model = ModelService();

  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();

  String result = "No result";

  @override
  void initState() {
    super.initState();
    model.loadModel();
  }

  String getLabel(List<double> output) {
    int index = output.indexOf(output.reduce((a, b) => a > b ? a : b));

    if (index == 0) return "Severe";
    if (index == 1) return "Moderate";
    return "Healthy";
  }

  void predict() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    double age = double.parse(ageController.text);

    var output = model.predict(weight, height, age);
    String label = getLabel(output);

    setState(() {
      result = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PoshanEye")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: "Weight (kg)"),
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: "Height (cm)"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age (months)"),
            ),
            SizedBox(height: 20),

            ElevatedButton(onPressed: predict, child: Text("Predict")),

            SizedBox(height: 20),

            Text(
              "Result: $result",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
