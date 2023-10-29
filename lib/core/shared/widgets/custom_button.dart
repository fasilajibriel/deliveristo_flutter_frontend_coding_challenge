import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_container.dart';
import 'package:flutter/material.dart';

/// A customizable button widget for user interaction.
///
/// The `CustomButton` widget is used to create interactive buttons in the
/// application. It offers flexibility in defining the button's appearance and
/// behavior, including an optional leading icon, the tap action, and the
/// button's child widget.
class CustomButton extends StatelessWidget {
  /// A callback function that is executed when the button is tapped.
  final VoidCallback onTap;

  /// The child widget to be displayed within the button.
  final Widget child;

  /// An optional icon widget that can be displayed before the child widget.
  final bool leadingIcon;

  final bool halfPadding;

  /// Creates a [CustomButton] with the required [onTap] and [child], and an
  /// optional [leadingIcon] and [key].
  ///
  /// The [onTap] function is called when the button is tapped. The [child]
  /// widget represents the content of the button. If provided, the
  /// [leadingIcon] is displayed to the left of the [child] widget. An optional
  /// [key] can be used to specify a key for the widget.
  const CustomButton({
    required this.onTap,
    required this.child,
    this.leadingIcon = false,
    this.halfPadding = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(halfPadding ? ThemeConstants.defaultPadding / 2 : ThemeConstants.defaultPadding),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon)
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png',
                  width: 20.0,
                  height: 20.0,
                  fit: BoxFit.cover,
                ),
              if (leadingIcon)
                const SizedBox(
                  width: ThemeConstants.defaultPadding,
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
