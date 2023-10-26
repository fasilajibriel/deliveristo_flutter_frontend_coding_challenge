import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:flutter/material.dart';

/// A widget representing the user's history view.
///
/// This widget is used to display the user's history of activities or
/// transactions. It can show a list of past events, orders, or any historical
/// data relevant to the user.
///
/// Use this widget to navigate to the user's history view within your
/// application.
class HistoryView extends StatefulWidget {
  /// Creates a [HistoryView].
  ///
  /// The [key] parameter is an optional key that can be used to identify this
  /// widget in the widget tree.
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return const Content(
      title: "Gen\nHistory",
    );
  }
}
