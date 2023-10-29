import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestTypeRadioButton extends StatefulWidget {
  const RequestTypeRadioButton({super.key});

  @override
  State<RequestTypeRadioButton> createState() => _RequestTypeRadioButtonState();
}

class _RequestTypeRadioButtonState extends State<RequestTypeRadioButton> {
  @override
  Widget build(BuildContext context) {
    final GeneratorStateProvider generatorStateProviderListner =
        context.watch<GeneratorStateProvider>();
    final GeneratorStateProvider generatorStateProviderEvent =
        context.read<GeneratorStateProvider>();

    return Column(
      children: [
        RadioListTile(
          value: 0,
          groupValue: generatorStateProviderListner.getRadioButtonValue,
          onChanged: generatorStateProviderEvent.setRadioButtonValue,
          title: const Text("Generate One Image"),
        ),
        RadioListTile(
          value: 1,
          groupValue: generatorStateProviderListner.getRadioButtonValue,
          onChanged: generatorStateProviderEvent.setRadioButtonValue,
          title: const Text("Generate List Of Images"),
        ),
        const SizedBox(
          height: ThemeConstants.defaultPadding,
        ),
      ],
    );
  }
}
