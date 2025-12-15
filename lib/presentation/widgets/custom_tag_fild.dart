import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart';

class CustomTagFild extends StatefulWidget {
  const CustomTagFild({super.key});

  @override
  State<CustomTagFild> createState() => _CustomTagFildState();
}

class _CustomTagFildState extends State<CustomTagFild> {
  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  List tags = [];

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: _globalKey,
      itemCount: tags.length,
      columns: 6,
      textField: TagsTextField(
        textStyle: context.textTheme.bodyMedium!,
        onSubmitted: (string) {
          setState(() {
            tags.add(Item(title: string));
          });
        },
      ),
      itemBuilder: (index) {
        final Item currentItem = tags[index];

        return ItemTags(
          index: index,
          title: currentItem.title!,
          customData: currentItem.customData,
          textStyle: context.textTheme.bodySmall!,
          combine: ItemTagsCombine.withTextBefore,
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                tags.removeAt(index);
              });
              return true;
            },
          ),
        );
      },
    );
  }
}
