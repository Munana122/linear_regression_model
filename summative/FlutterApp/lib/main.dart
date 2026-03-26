import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WageGapApp());
}

class WageGapApp extends StatelessWidget {
  const WageGapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wage Gap Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
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
  String _resultText = '';
  bool _loading = false;

  static const String _apiUrl = 'http://10.0.2.2:8000/predict';

  Future<void> _predict() async {
    final input = _yearController.text.trim();
    final year = int.tryParse(input);

    if (year == null) {
      setState(() {
        _resultText = 'Please enter a valid year.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _resultText = '';
    });

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'year': year}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final result = decoded['predicted_gap_percentage'];
        setState(() {
          _resultText =
              'In $year, the predicted wage gap is $result%.';
        });
      } else {
        setState(() {
          _resultText =
              'Prediction failed. Server responded with ${response.statusCode}.';
        });
      }
    } catch (_) {
      setState(() {
        _resultText = 'Could not connect to the API.';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gender Wage Gap Predictor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter year',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _loading ? null : _predict,
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Predict Wage Gap'),
            ),
            const SizedBox(height: 16),
            Text(
              _resultText,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
