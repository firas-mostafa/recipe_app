import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/widgets/custom_tag_fild.dart';

class AddNewRecipe extends StatelessWidget {
  const AddNewRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [CustomTagFild()]);
  }
}
