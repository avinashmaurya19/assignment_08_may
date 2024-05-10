import 'package:flutter/material.dart';
import 'package:flutter_assignment_new/bloc/sortgroup/sortgroup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/constants/constants.dart';
import '../bloc/countrybloc/country_bloc.dart';

class SortDropDownFilterWidget extends StatefulWidget {
  const SortDropDownFilterWidget({super.key});

  @override
  State<SortDropDownFilterWidget> createState() =>
      _SortDropDownFilterWidgetState();
}

class _SortDropDownFilterWidgetState extends State<SortDropDownFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortgroupBloc, SortgroupState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          child: DropdownButton<String>(
            // value: state.sortValue,
            items: sortItems.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (value) {
              // BlocProvider.of<SortgroupBloc>(context)
              //     .add(OnChangeSortOption(value!));
              // BlocProvider.of<CountryBloc>(context).add(
              //   ChangeSortEvent(
              //     sortValue: state.sortValue,
              //   ),
              // );
            },
          ),
        );
      },
    );
  }
}
