import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assignment_new/bloc/countrybloc/country_bloc.dart';
import 'package:flutter_assignment_new/data/models/country_model.dart';
import 'package:flutter_assignment_new/widgets/country_widget.dart';
import 'package:flutter_assignment_new/widgets/sort_dropdown_filter_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SortOption { name, population, area }

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

  SortOption _selectedSortOption = SortOption.name;

  @override
  void initState() {
    _filteredCountryList = widget.countryList;
    super.initState();
  }

  void _sortCountryList(SortOption option) {
    setState(() {
      _selectedSortOption = option;
      switch (_selectedSortOption) {
        case SortOption.name:
          _filteredCountryList
              .sort((a, b) => a.nameCommon.compareTo(b.nameCommon));
          break;
        case SortOption.population:
          _filteredCountryList
              .sort((b, a) => a.population.compareTo(b.population));
          break;
        case SortOption.area:
          _filteredCountryList.sort((b, a) => a.area.compareTo(b.area));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    //title of country
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 8, top: 15, bottom: 15),
                      child: Text(widget.groupTitle,
                          style: const TextStyle(fontSize: 15)),
                    ),
                  ),
                ),
                if (_expanded) ...[
                  //search feature
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      // width: MediaQuery.of(context).size.width / 4,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _filteredCountryList = widget.countryList
                                .where((country) => country.nameCommon
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            _sortCountryList(_selectedSortOption);
                            // BlocProvider.of<CountryBloc>(context).add(
                            //     SortNamePopulationEvent(
                            //         option: SortOption.name.toString()));
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
                    ),
                  ),
                  SizedBox(width: 8),
                  // const SizedBox(
                  //   height: 50,
                  //   child: SortDropDownFilterWidget(),
                  // )

                  //dropdown
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: DropdownButton<SortOption>(
                        value: _selectedSortOption,
                        onChanged: (option) {
                          _sortCountryList(option!);
                          // BlocProvider.of<CountryBloc>(context).add(
                          //     SortNamePopulationEvent(option: option.toString()));
                        },
                        items: const [
                          DropdownMenuItem(
                            value: SortOption.name,
                            child: Text('Name'),
                          ),
                          DropdownMenuItem(
                            value: SortOption.population,
                            child: Text('Population'),
                          ),
                          DropdownMenuItem(
                            value: SortOption.area,
                            child: Text('Area'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
            if (_expanded) buildGrid(),
          ],
        );
      },
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
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
            // CountryWidget(countryList: widget.countryList[index]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Image.network(_filteredCountryList[index].flagPng),
                  // child: Image.network(widget.countryList[index].flagPng),
                ),
                SizedBox(
                  // height: 20,
                  child: Text(
                    _filteredCountryList[index].nameCommon,
                    // widget.countryList[index].nameCommon,
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
}
