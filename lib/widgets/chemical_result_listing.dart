import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:water_quality_app/objects/chemical_standard.dart';

class ChemicalResultListing extends StatelessWidget {
  const ChemicalResultListing({
    super.key,
    required this.standard,
    required this.controller
  });
  final ChemicalStandard standard;
  final TextEditingController controller;

  bool get isStandardMet => standard.isValueInRange(double.parse(controller.text));

  @override
  Widget build(BuildContext context) {
    const resultColor =
        Color.fromARGB(255, 6, 6, 6);

    return Expanded(
      child: Card(
        child: ListTile(
          tileColor: isStandardMet
              ? const Color.fromARGB(255, 182, 214, 204)
              : const Color.fromARGB(255, 255, 200, 200),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.square_rounded,
                color: resultColor,
                size: 50,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              TextField(
                  controller: controller,decoration: const InputDecoration(labelText: "Enter your number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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
      ),
    );
  }
}
