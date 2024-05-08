import 'package:flutter/material.dart';
import 'package:flutter_assignment_new/data/models/country_model.dart';
import 'package:flutter_assignment_new/presentation/widgets/country_widget.dart';
import 'package:flutter_assignment_new/presentation/widgets/groupwidgets/group_background_widget.dart';
import 'package:flutter_assignment_new/presentation/widgets/groupwidgets/group_header_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class GroupGridWidget extends StatefulWidget {
  const GroupGridWidget({
    required this.groupTitle,
    required this.countryList,
    super.key,
  });

  final String groupTitle;
  final List<CountryModel> countryList;

  @override
  _GroupGridWidgetState createState() => _GroupGridWidgetState();
}

class _GroupGridWidgetState extends State<GroupGridWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(12.0).copyWith(top: 0),
      sliver: MultiSliver(
        pushPinnedChildren: true,
        children: [
          SliverStack(
            insetOnOverlap: true,
            children: [
              const SliverPositioned.fill(
                top: GroupHeaderWidget.padding,
                child: GroupBackgroundWidget(),
              ),
              MultiSliver(
                children: [
                  SliverPinnedHeader(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      child: GroupHeaderWidget(title: widget.groupTitle),
                    ),
                  ),
                  if (_expanded)
                    SliverClip(
                      child: buildGrid(),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGrid() => SliverGrid(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 50,
                        child:
                            Image.network(widget.countryList[index].flagPng)),
                    SizedBox(
                      height: 20,
                      child: Text(
                        widget.countryList[index].nameCommon,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CountryWidget(countryModel: widget.countryList[index])),
            );
          },
          childCount: widget.countryList.length,
        ),
      );
}
