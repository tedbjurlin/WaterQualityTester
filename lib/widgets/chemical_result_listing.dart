import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:water_quality_app/objects/chemical_standard.dart';

class ChemicalResultListing extends StatefulWidget {
  const ChemicalResultListing({
    super.key,
    required this.standard,
    required this.controller
  });
  final ChemicalStandard standard;
  final TextEditingController controller;

  @override
  State<ChemicalResultListing> createState() => _ChemicalResultListingState();
}

class _ChemicalResultListingState extends State<ChemicalResultListing> {

  bool get isStandardMet => widget.standard.isValueInRange(double.parse(widget.controller.text));

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
          leading: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
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
            ],
          ),
          title: Row(
            children: [
              Expanded(
                child: TextField(
                    controller: widget.controller,decoration: const InputDecoration(labelText: "Enter your number"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onSubmitted: (value) => setState(() {
                      if (widget.controller.text == "") {
                        widget.controller.text = "0";
                      }
                    }),
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              const Spacer(),
              Text(widget.standard.name),
              const SizedBox(width: 10),
              Text(
                  'Ideal: ${widget.standard.lo}-${widget.standard.hi} ${widget.standard.units ?? ''}'),
            ],
          ),
          onTap: () => widget.standard.description == null
              ? null
              : showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(widget.standard.name),
                    content: Text(widget.standard.description ?? ''),
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
