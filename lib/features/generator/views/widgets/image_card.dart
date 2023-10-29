import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_container.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/state/onboarding_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatefulWidget {
  final String imageUrl;
  final bool longPress;
  const ImageCard({
    required this.imageUrl,
    this.longPress = true,
    super.key,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = context.read<OnboardingStateProvider>().getUser;

    return Stack(
      children: [
        CustomContainer(
          child: GestureDetector(
            onLongPress: widget.longPress
                ? () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Save Image?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: ThemeConstants.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        content: Text(
                          "Save Image ${user == const UserModel.empty() ? "On my device" : "On the cloud"}",
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Save"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    )
                : null,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: NetworkImage(
                    widget.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
