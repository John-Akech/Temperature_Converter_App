import 'package:flutter/material.dart';

// Entry point of the app
void main() {
  runApp(const TemperatureConverterApp());
}

// Root widget of the temperature converter app
class TemperatureConverterApp extends StatefulWidget {
  const TemperatureConverterApp({super.key});

  @override
  _TemperatureConverterAppState createState() => _TemperatureConverterAppState();
}

// State class that manages the app's data and behavior
class _TemperatureConverterAppState extends State<TemperatureConverterApp> {
  // Variable to store selected conversion type (Celsius to Fahrenheit or vice versa)
  String? selectedConversion;

  // Controller to handle user input from the text field
  final TextEditingController tempController = TextEditingController();

  // Variable to store the converted temperature result
  String convertedTemp = '';

  // List to store the history of conversions
  List<String> conversionHistory = [];

  // Function to handle temperature conversion
  void convertTemperature() {
    // Parse the input temperature; if invalid, set to 0
    double inputTemp = double.tryParse(tempController.text) ?? 0;

    // Convert Celsius to Fahrenheit
    if (selectedConversion == 'Celsius to Fahrenheit') {
      double result = (inputTemp * 9 / 5) + 32;
      setState(() {
        convertedTemp = result.toStringAsFixed(2); // Store converted temperature
        conversionHistory.add('${inputTemp} °C = $convertedTemp °F'); // Add to history
      });
    }
    // Convert Fahrenheit to Celsius
    else if (selectedConversion == 'Fahrenheit to Celsius') {
      double result = (inputTemp - 32) * 5 / 9;
      setState(() {
        convertedTemp = result.toStringAsFixed(2); // Store converted temperature
        conversionHistory.add('${inputTemp} °F = $convertedTemp °C'); // Add to history
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: 'Temperature Converter', // App title
      home: Scaffold(
        backgroundColor: Colors.blue, // Background color of the app
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Converter',
              style: TextStyle(color: Colors.white), // White text color for the title
            ),
          ),
          backgroundColor: Colors.blueGrey, // AppBar background color
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding around the content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for selecting the conversion type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true, // Make dropdown take full width
                        value: selectedConversion, // Current selection
                        items: <String>[
                          'Celsius to Fahrenheit',
                          'Fahrenheit to Celsius'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value), // Display conversion type
                          );
                        }).toList(),
                        // When a new conversion type is selected
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedConversion = newValue; // Update the selection
                            convertedTemp = ''; // Clear the result when switching types
                          });
                        },
                        hint: const Text('Select Conversion'), // Hint text for dropdown
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Spacing between widgets

                // Input field for entering the temperature to convert
                TextField(
                  controller: tempController, // Connect controller to this field
                  decoration: const InputDecoration(
                    labelText: 'Enter temperature',
                    border: OutlineInputBorder(), // Add border to the input field
                  ),
                  keyboardType: TextInputType.number, // Expect numerical input
                ),
                const SizedBox(height: 20), // Spacing

                // Label for displaying the converted temperature
                const Text(
                  'Converted temperature:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10), // Spacing

                // Text displaying the converted temperature
                Text(
                  convertedTemp.isEmpty ? 'No conversion yet' : convertedTemp,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 20), // Spacing

                // Button to trigger the temperature conversion
                ElevatedButton(
                  onPressed: selectedConversion != null
                      ? convertTemperature // Call conversion function if type is selected
                      : null, // Disable button if no conversion type is selected
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 20), // Spacing

                // Label for conversion history
                const Text(
                  'Conversion History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10), // Spacing

                // List displaying the history of conversions
                ListView.builder(
                  shrinkWrap: true, // Only take up necessary space
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling within ListView
                  itemCount: conversionHistory.length, // Number of items in the history
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(conversionHistory[index]), // Display conversion details
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
