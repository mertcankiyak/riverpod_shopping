import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kartal/kartal.dart';

class ExpansionTileWidget extends StatefulWidget {
  ExpansionTileWidget({super.key, required this.title, required this.child});
  String? title;
  Widget? child;

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            trailing: Icon(_isExpanded
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_right_sharp),
            title: Text(
              "${widget.title}",
              style: context.general.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: widget.child),
            ],
          ),
        ),
      ],
    );
  }
}
