import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magical_walls/core/constants/app_text.dart';

import '../../core/constants/app_colors.dart';

class CommonSelectionList extends StatelessWidget {
  final List<String> items;
  final Function(String) onSelect; // callback when user selects an item
  final double height;

  const CommonSelectionList({
    Key? key,
    required this.items,
    required this.onSelect,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CommonColors.textFieldGrey),
      ),
      child: ListView.separated(

        scrollDirection: Axis.vertical,


        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(contentPadding: EdgeInsets.fromLTRB(8, 3, 3, 0), onTap: (){
            onSelect(item);
          },  title:  Text(
            item,
            style: CommonTextStyles.regular16,
          ),
                    );
        },
        separatorBuilder: (context, index) => Divider(
          color: CommonColors.textFieldGrey,
          thickness: .5,
          height: 1,
        ),
      ),
    );
  }
}
