import 'package:flutter/material.dart';
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
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CountryBloc>(context).add(
                    ChangeGroupAndSortEvent(
                      sortValue: state.sortValue,
                      groupValue: state.groupValue,
                    ),
                  );
                },
                child: const Text('Apply'),
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
            const Text('Sorted By', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: state.sortValue,
              items: sortItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                BlocProvider.of<SortgroupBloc>(context)
                    .add(onChangeSortOption(value!));
                // .onChangeSortOption(value!);
              },
            ),
          ],
        );
      case 'group':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Grouped By', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: state.groupValue,
              items: groupItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                // BlocProvider.of<SortGroupCubit>(context)
                //     .onChangeGroupOption(value!);
                BlocProvider.of<SortgroupBloc>(context)
                    .add(onChangeGroupOption(value!));
              },
            ),
          ],
        );
    }
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item,
    child: Text(item),
  );
}
