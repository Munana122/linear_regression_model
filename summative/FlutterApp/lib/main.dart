import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const GenderGapApp());
}

class GenderGapApp extends StatelessWidget {
  const GenderGapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final TextEditingController _yearController = TextEditingController();
  String _result = "";
  bool _isLoading = false;

  // Replace with your actual Render URL
  final String apiUrl = "https://linear-regression-model-fz89.onrender.com/predict";

  Future<void> getPrediction() async {
    if (_yearController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _result = "";
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"year": int.parse(_yearController.text)}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = "Predicted Wage Gap: ${data['predicted_gap_percentage']}%";
        });
      } else {
        setState(() {
          _result = "Error: Could not get prediction.";
        });
      }
    } catch (e) {
      setState(() {
        _result = "Connection Error. Check if API is live!";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wage Gap Predictor")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Empowering Women: Future Economic Projections",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Requirement: TextField for input
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Year (e.g., 2030)",
              ),
            ),
            const SizedBox(height: 20),
            // Requirement: Button with text 'Predict'
            ElevatedButton(
              onPressed: _isLoading ? null : getPrediction,
              child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text("Predict"),
            ),
            const SizedBox(height: 30),
            // Requirement: Display area for result
            Text(
              _result,
              style: const TextStyle(fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}