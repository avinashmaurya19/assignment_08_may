import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assignment_new/bloc/sortgroup/sortgroup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/constants/constants.dart';
import '../bloc/countrybloc/country_bloc.dart';

class SortGroupWidget extends StatelessWidget {
  const SortGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortgroupBloc, SortgroupState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDropDownButton('sort', context, state),
              buildDropDownButton('group', context, state),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<CountryBloc>(context).add(
                    ChangeGroupAndSortEvent(
                      sortValue: state.sortValue,
                      groupValue: state.groupValue,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(width: 0),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              
            ],
          ),
        );
      },
    );
  }

  buildDropDownButton(String type, BuildContext context, SortgroupState state) {
    switch (type) {
      case 'sort':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sorted By', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: state.sortValue,
              items: sortItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                BlocProvider.of<SortgroupBloc>(context)
                    .add(OnChangeSortOption(value!));
              },
            ),
          ],
        );
      case 'group':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Grouped By', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: state.groupValue,
              items: groupItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                BlocProvider.of<SortgroupBloc>(context)
                    .add(OnChangeGroupOption(value!));
              },
            ),
          ],
        );
    }
  }
}
