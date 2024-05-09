import 'package:flutter/material.dart';
import 'package:flutter_assignment_new/data/models/country_model.dart';
import 'package:flutter_assignment_new/widgets/country_widget.dart';

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
  late List<CountryModel> _filteredCountryList;

  @override
  void initState() {
    _filteredCountryList = widget.countryList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(widget.groupTitle,
                      style: const TextStyle(fontSize: 26)),
                ),
              ),
            ),
            if (_expanded) ...[
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _filteredCountryList = widget.countryList
                          .where((country) => country.nameCommon
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      print(_filteredCountryList);
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search country...',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color.fromARGB(232, 229, 227, 231),
                  ),
                ),
              )
            ]
          ],
        ),
        if (_expanded) buildGrid(),
      ],
    );
  }

  Widget buildGrid() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: _filteredCountryList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) =>
                  CountryWidget(countryList: _filteredCountryList[index]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: Image.network(_filteredCountryList[index].flagPng),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      _filteredCountryList[index].nameCommon,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
