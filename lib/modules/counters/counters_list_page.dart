import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/config/presentation/cubit/counter/counter_cubit.dart';
import 'package:e_ticket/modules/counters/widgets/counter_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountersListPage extends StatelessWidget {
  const CountersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalate.primaryColor,
        title: Text(
          'Counters',
          style: TextStyle(color: ColorsPalate.onPrimaryColor),
        ),
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
          bloc: CounterCubit(sl())..loadCounters(),
          builder: (context, state) {
            if (state is CounterFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is CounterSuccess) {
              return ListView.builder(
                itemCount: state.counters.length,
                itemBuilder: (context, index) {
                  return CounterListItem(data: state.counters[index]);
                },
              );
            }
            if (state is CounterLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: ColorsPalate.primaryColor,
              ));
            }
            return Center(
              child: Text('Loaging ......'),
            );
          }),
    );
  }
}
