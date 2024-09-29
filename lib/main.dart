import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatefulWidget {
  const TemperatureConverterApp({super.key});

  @override
  _TemperatureConverterAppState createState() => _TemperatureConverterAppState();
}

class _TemperatureConverterAppState extends State<TemperatureConverterApp> {
  String? selectedConversion;
  final TextEditingController tempController = TextEditingController();
  String convertedTemp = '';
  List<String> conversionHistory = [];

  void convertTemperature() {
    double inputTemp = double.tryParse(tempController.text) ?? 0;

    if (selectedConversion == 'Celsius to Fahrenheit') {
      double result = (inputTemp * 9 / 5) + 32;
      setState(() {
        convertedTemp = result.toStringAsFixed(2);
        conversionHistory.add('${inputTemp} °C = $convertedTemp °F');
      });
    } else if (selectedConversion == 'Fahrenheit to Celsius') {
      double result = (inputTemp - 32) * 5 / 9;
      setState(() {
        convertedTemp = result.toStringAsFixed(2);
        conversionHistory.add('${inputTemp} °F = $convertedTemp °C');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
            title: const Center(
              child: Text(
                'Converter',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.blueGrey),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for selecting conversion type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedConversion,
                        items: <String>['Celsius to Fahrenheit', 'Fahrenheit to Celsius']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedConversion = newValue;
                            convertedTemp = ''; // Clear converted temperature when changing conversion type
                          });
                        },
                        hint: const Text('Select Conversion'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Temperature input field
                TextField(
                  controller: tempController,
                  decoration: const InputDecoration(
                    labelText: 'Enter temperature',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                // Non-editable output for converted temperature
                const Text(
                  'Converted temperature:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  convertedTemp.isEmpty ? 'No conversion yet' : convertedTemp,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 20),
                // Convert button
                ElevatedButton(
                  onPressed: selectedConversion != null ? convertTemperature : null,
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 20),
                // Conversion history
                const Text(
                  'Conversion History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Display conversion history
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: conversionHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(conversionHistory[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
