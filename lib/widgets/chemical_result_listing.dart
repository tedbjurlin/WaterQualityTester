import 'package:flutter/material.dart';

import 'package:water_test_scanner/water_test_scanning.dart';

import 'package:water_quality_app/objects/chemical_standard.dart';

class ChemicalResultListing extends StatelessWidget {
  const ChemicalResultListing({
    super.key,
    required this.standard,
    required this.result,
  });
  final ChemicalStandard standard;
  final ColorOutput result;

  bool get isStandardMet => standard.isValueInRange(result.value);

  @override
  Widget build(BuildContext context) {
    final resultColor =
        Color.fromARGB(255, result.red, result.green, result.blue);
    final displayValue = result.value.isFinite
        ? ((result.value * 1000).truncate() / 1000)
            .toString()
            .replaceFirst(RegExp(r'.0$'), '')
        : 'Unknown';

    return Card(
      child: ListTile(
        tileColor: isStandardMet
            ? const Color.fromARGB(255, 182, 214, 204)
            : const Color.fromARGB(255, 255, 200, 200),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.square_rounded,
              color: resultColor,
              size: 50,
              shadows: const [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              '$displayValue ${standard.units ?? ''}',
              style: TextStyle(
                color: isStandardMet ? Colors.black : Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            const Spacer(),
            Text(standard.name),
          ],
        ),
        subtitle: Row(
          children: [
            const Spacer(),
            Text(
                'Ideal: ${standard.lo}-${standard.hi} ${standard.units ?? ''}'),
          ],
        ),
        onTap: () => standard.description == null
            ? null
            : showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(standard.name),
                  content: Text(standard.description ?? ''),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('back'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
