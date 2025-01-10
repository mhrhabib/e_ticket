import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_fare_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../tickets/presentation/cubit/ticket_sale_cubit.dart';

Widget buildTicketList({BuildContext? context, List<Prices>? items, bool? isStudent, bool? isAdvanced, String? selectedDate}) {
  return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: items!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final int originalPrice = items[index].generalPrice!;

        final int discountedPrice = isStudent! ? items[index].studentPrice! : originalPrice;

        return InkWell(
          onTap: () {
            if (isAdvanced! && selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a journey date'),
                ),
              );
              return;
            }

            if (storage.read('userId') != null && storage.read('counterId') != null) {
              context.read<TicketSaleCubit>().addTicketSale(
                    userId: storage.read('userId'),
                    ticketRouteId: items[index].routeId!,
                    fromTicketCounterId: storage.read('counterId'),
                    toTicketCounterId: items[index].toTicketCounterId!,
                    type: isStudent ? 'Student' : 'General',
                    price: isStudent ? discountedPrice.toDouble() : originalPrice.toDouble(),
                    isAdvanced: isAdvanced ? true : false,
                    deviceId: 1,
                    journeyDate: isAdvanced ? selectedDate : '',
                  );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorsPalate.secondaryColor,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  items[index].toTicketCounterNameBn!,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorsPalate.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isStudent ? '$discountedPrice' : '$originalPrice',
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorsPalate.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

//   Align(
            //     alignment: Alignment.centerLeft,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 12.0, top: 12),
            //       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //         Text('User'),
            //         Gap(2),
            //         Text(
            //           '*',
            //           style: TextStyle(color: Colors.red),
            //         ),
            //       ]),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(left: 12, right: 12),
            //     child: BlocBuilder<UserCubit, UserState>(
            //       builder: (context, state) {
            //         if (state is UserLoading) {
            //           return const CustomDropdownShimmer();
            //         }
            //         if (state is UserFailUre) {
            //           return const Text('No item');
            //         }
            //         if (state is UserSuccess) {
            //           return CustomDropdown<String>(
            //             value: state.selectedUser?.name, // Use selectedUser's name
            //             items: state.users.map((user) => user.name!).toList(),
            //             onChanged: (selectedName) {
            //               final selectedUser = state.users.firstWhere((user) => user.name == selectedName);
            //               context.read<UserCubit>().selectUser(selectedUser); // Update selectedUser
            //               setState(() {
            //                 selectedUserId = selectedUser.id;
            //                 fromTicketCounterId = selectedUser.ticketCounterId!;
            //               });
            //             },
            //             hintText: 'name',
            //             labelText: 'Select User',
            //           );
            //         }
            //         return const SizedBox.shrink();
            //       },
            //     ),
            //   ),
            //   Align(
            //     alignment: Alignment.centerLeft,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 12.0, top: 12),
            //       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //         Text('Routes'),
            //         Gap(2),
            //         Text(
            //           '*',
            //           style: TextStyle(color: Colors.red),
            //         ),
            //       ]),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(left: 12, right: 12),
            //     child: BlocBuilder<TicketRouteCubit, TicketRouteState>(
            //       builder: (context, state) {
            //         if (state is TicketRouteLoading) {
            //           return const CustomDropdownShimmer();
            //         }
            //         if (state is TicketRouteFailUre) {
            //           return const Text('No item');
            //         }
            //         if (state is TicketRouteSuccess) {
            //           return CustomDropdown<String>(
            //             value: state.ticketRoute?.name, // Use selectedUser's name
            //             items: state.ticketRoutes.map((user) => user.name!).toList(),
            //             onChanged: (selectedName) {
            //               final selectedRoute = state.ticketRoutes.firstWhere((user) => user.name == selectedName);
            //               context.read<TicketRouteCubit>().selectRoute(selectedRoute); // Update selectedUser
            //               setState(() {
            //                 selectedRouteId = selectedRoute.id;
            //               });
            //             },
            //             hintText: 'name',
            //             labelText: 'Select route',
            //           );
            //         }
            //         return const SizedBox.shrink();
            //       },
            //     ),
            //   ),
            //   Align(
            //     alignment: Alignment.centerLeft,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 12.0, top: 12),
            //       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //         Text('To Ticket Counter'),
            //         Gap(2),
            //         Text(
            //           '*',
            //           style: TextStyle(color: Colors.red),
            //         ),
            //       ]),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(left: 12, right: 12),
            //     child: BlocBuilder<CounterCubit, CounterState>(
            //       builder: (context, state) {
            //         if (state is CounterLoading) {
            //           return const CustomDropdownShimmer();
            //         }
            //         if (state is CounterFailure) {
            //           return const Text('No item');
            //         }
            //         if (state is CounterSuccess) {
            //           return CustomDropdown<String>(
            //             value: state.counter?.name, // Use selectedUser's name
            //             items: state.counters.map((user) => user.name!).toList(),
            //             onChanged: (selectedName) {
            //               final selectedRoute = state.counters.firstWhere((user) => user.name == selectedName);
            //               context.read<CounterCubit>().selectCounter(selectedRoute); // Update selectedUser
            //               setState(() {
            //                 selectedCounterId = selectedRoute.id;
            //               });
            //             },
            //             hintText: 'name',
            //             labelText: 'Select counter',
            //           );
            //         }
            //         return const SizedBox.shrink();
            //       },
            //     ),
            //   ),
            //   Align(
            //     alignment: Alignment.centerLeft,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 12.0, top: 12),
            //       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //         Text('Type'),
            //         Gap(2),
            //         Text(
            //           '*',
            //           style: TextStyle(color: Colors.red),
            //         ),
            //       ]),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(left: 12, right: 12),
            //     child: BlocBuilder<TicketTypeCubit, TicketTypeState>(
            //       builder: (context, state) {
            //         if (state is TicketTypeLoading) {
            //           return const CustomDropdownShimmer();
            //         }
            //         if (state is TicketTypeFailUre) {
            //           return const Text('No item');
            //         }
            //         if (state is TicketTypeSuccess) {
            //           return CustomDropdown<String>(
            //             value: state.ticketType?.name, // Use selectedUser's name
            //             items: state.ticketTypes.map((user) => user.name!).toList(),
            //             onChanged: (selectedName) {
            //               final selectedRoute = state.ticketTypes.firstWhere((user) => user.name == selectedName);
            //               context.read<TicketTypeCubit>().selectType(selectedRoute); // Update selectedUser
            //               setState(() {
            //                 selectedType = selectedRoute.name;
            //                 selectedUserId != null && selectedRouteId != null && selectedCounterId != null && selectedType != null
            //                     ? context.read<TicketPriceCubit>().fetchTicketPrice(
            //                           userId: selectedUserId.toString(),
            //                           ticketRouteId: selectedRouteId.toString(),
            //                           toCounterId: selectedCounterId.toString(),
            //                           type: selectedType!,
            //                         )
            //                     : null;
            //               });
            //             },
            //             hintText: 'name',
            //             labelText: 'Select type',
            //           );
            //         }
            //         return const SizedBox.shrink();
            //       },
            //     ),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const Text('Is Advanced', style: TextStyle(fontSize: 16)),
            //         Checkbox(
            //           value: isAdvanced,
            //           onChanged: (value) {
            //             setState(() {
            //               isAdvanced = value!;
            //               if (!isAdvanced) {
            //                 selectedDate = null; // Reset date if not advanced
            //               }
            //             });
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            //   if (isAdvanced)
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             selectedDate ?? 'Select Journey Date',
            //             style: TextStyle(
            //               fontSize: 16,
            //               color: selectedDate == null ? Colors.grey : Colors.black,
            //             ),
            //           ),
            //           ElevatedButton(
            //             onPressed: () => _selectDate(context),
            //             child: const Text('Pick Date'),
            //           ),
            //         ],
            //       ),
            //     ),
            //   SizedBox(
            //     height: 80,
            //     child: BlocBuilder<TicketPriceCubit, TicketPriceState>(
            //       builder: (context, state) {
            //         if (state is TicketPriceLoading) {
            //           return Center(child: CircularProgressIndicator());
            //         }
            //         if (state is TicketPriceLoaded) {
            //           price = state.price.price!.toStringAsFixed(2);
            //           return Container(
            //             margin: EdgeInsets.all(12),
            //             padding: EdgeInsets.all(12),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(12.0),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.black.withOpacity(0.1),
            //                   blurRadius: 10.0,
            //                   offset: Offset(0, 5),
            //                 ),
            //               ],
            //             ),
            //             child: Center(
            //               child: Text(
            //                 'Price: \$${state.price.price!.toStringAsFixed(2)}',
            //                 style: TextStyle(fontSize: 20),
            //               ),
            //             ),
            //           );
            //         }
            //         if (state is TicketPriceError) {
            //           return Center(
            //             child: Text(
            //               state.message,
            //               style: TextStyle(color: Colors.red),
            //             ),
            //           );
            //         }
            //         return Center(child: Text('Select options to calculate price'));
            //       },
            //     ),
            //   ),
            //   BlocConsumer<TicketSaleCubit, TicketSaleState>(
            //     listener: (context, state) {
            //       if (state is TicketSaleSuccess) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text('Ticket added successfully!')),
            //         );
            //         setState(() {
            //           selectedUserId = null;
            //           selectedRouteId = null;
            //           selectedCounterId = null;
            //           selectedType = null;
            //           fromTicketCounterId = null;
            //           price = null;
            //           isAdvanced = false;
            //           selectedDate = null;
            //           _resetAllSelections();
            //         });
            //       } else if (state is TicketSaleFailed) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text(state.message)),
            //         );
            //       }
            //     },
            //     builder: (context, state) {
            //       if (state is TicketSaleLoading) {
            //         return const CircularProgressIndicator();
            //       }
            //       return ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: ColorsPalate.primaryColor,
            //           foregroundColor: ColorsPalate.onPrimaryColor,
            //         ),
            //         onPressed: () {
            //           if (isAdvanced && selectedDate == null) {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                 content: Text('Please select a journey date'),
            //               ),
            //             );
            //             return;
            //           }
        
            //           if (selectedUserId != null && selectedRouteId != null && selectedCounterId != null && selectedType != null && fromTicketCounterId != null) {
            //             context.read<TicketSaleCubit>().addTicketSale(
            //                   userId: selectedUserId!,
            //                   ticketRouteId: selectedRouteId!,
            //                   fromTicketCounterId: fromTicketCounterId!,
            //                   toTicketCounterId: selectedCounterId!,
            //                   type: selectedType!,
            //                   price: double.parse(price!),
            //                   isAdvanced: isAdvanced ? true : false,
            //                   deviceId: 1,
            //                   journeyDate: isAdvanced ? selectedDate : '',
            //                 );
            //           }
            //         },
            //         child: const Text('Add Ticket'),
            //       );
            //     },
            //   ),