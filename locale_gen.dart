// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main() async {
  final inputFile = File('assets/translations/translations.csv');
  final outputFolder = Directory('assets/translations');

  // Check if the input file exists
  if (!await inputFile.exists()) {
    print('Error: The file "translations.csv" does not exist.');
    return;
  }

  // Ensure output directory exists
  if (!await outputFolder.exists()) {
    await outputFolder.create();
  }

  // Read the CSV file content
  final content = await inputFile.readAsString();
  if (content.isEmpty) {
    print('CSV file is empty');
    return;
  }

  // Parse the CSV content
  final lines = _parseCsv(content);
  if (lines.isEmpty) {
    print('No valid rows found in the CSV file');
    return;
  }

  // Parse the header line to get the column names
  final headers = lines.first;
  print('Headers: $headers');

  // Loop through each column (skip the first column, which is "KEYS")
  for (var i = 1; i < headers.length; i++) {
    final columnName = headers[i].trim();

    print('Processing column: $columnName');

    // Create a JSON map for the current column
    final jsonMap = <String, String>{};

    // Loop through each row in the CSV file, starting from the second line
    for (var j = 1; j < lines.length; j++) {
      final row = lines[j];

      // Ensure we have enough columns in this row
      if (row.length <= i) {
        print('Skipping line ${j + 1} due to insufficient columns');
        continue;
      }

      // Extract the key and value
      final key = row[0].trim();
      final value = row[i].trim();

      if (key.isNotEmpty && value.isNotEmpty) {
        jsonMap[key] = value;
        print('Adding entry: "$key": "$value"');
      }
    }

    // Write formatted JSON map to file
    final jsonFile = File('${outputFolder.path}/$columnName.json');
    const encoder = JsonEncoder.withIndent('  '); // Two-space indentation
    await jsonFile.writeAsString(encoder.convert(jsonMap),
        mode: FileMode.writeOnly);
    print('File created: ${jsonFile.path}');
  }

  print(
      'Formatted JSON files have been created in the "${outputFolder.path}" folder.');
}

/// A custom CSV parser to handle values enclosed in quotes and containing commas
List<List<String>> _parseCsv(String content) {
  final lines = content.split('\n').map((line) => line.trim()).toList();
  final result = <List<String>>[];

  for (var line in lines) {
    if (line.isEmpty) continue;

    final row = <String>[];
    var current = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < line.length; i++) {
      final char = line[i];

      if (char == '"' && (i == 0 || line[i - 1] != '\\')) {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        row.add(current.toString());
        current.clear();
      } else {
        current.write(char);
      }
    }

    row.add(current.toString());
    result.add(row.map((cell) => cell.replaceAll('""', '"')).toList());
  }

  return result;
}
