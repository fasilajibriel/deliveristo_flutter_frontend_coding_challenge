import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/image_list/image_list_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/views/widgets/image_card.dart';
import 'package:flutter/material.dart';

/// A widget for displaying a grid of images fetched from the Dog CEO API.
///
/// The `ImageGrid` class takes an `ImageListModel` as input and displays a grid
/// of dog images. The grid layout is defined using a `GridView.builder` with a
/// fixed number of columns, cross-axis spacing, and child aspect ratio. Images
/// are displayed within individual `ImageCard` widgets. This class includes a
/// variable declaration for the [imageList] parameter, which is a model
/// containing the list of dog images to be displayed.
class ImageGrid extends StatelessWidget {
  /// The model containing a list of dog images to display.
  final ImageListModel imageList;

  /// An option that allows users to logpress on an image card to save.
  final bool longPress;

  /// Creates an [ImageGrid] widget with the given [imageList].
  const ImageGrid({
    required this.imageList,
    required this.longPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: ThemeConstants.defaultPadding,
        crossAxisSpacing: ThemeConstants.defaultPadding,
      ),
      itemCount: imageList.images?.length ?? 0,
      itemBuilder: (context, index) {
        return ImageCard(
          imageUrl: imageList.images?[index] ?? "",
          longPress: longPress,
        );
      },
    );
  }
}
