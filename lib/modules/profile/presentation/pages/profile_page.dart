import 'package:e_ticket/core/common/helper/sale_service.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalate.primaryColor,
        title: Text(
          'Profile',
          style: TextStyle(color: ColorsPalate.buttonFontColor),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        //bloc: ProfileCubit(getProfileUseCase: sl())..loadProfilesData(),
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileFailure) {
            return Center(child: Text(state.message));
          }
          if (state is ProfileSuccess) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: Column(
                          children: [
                            // Profile Icon
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/logo.png'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Name
                            Text(
                              state.profilesModel.data!.name!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Email
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email, size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  state.profilesModel.data!.email!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Mobile
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone, size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  state.profilesModel.data!.mobile!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Status
                            Chip(
                              label: Text(
                                state.profilesModel.data!.status!,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: state.profilesModel.data!.status! == "Active" ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // User Likes
                    Text(
                      "Send ${state.profilesModel.data!.name!}'s data to server:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsPalate.primaryColor,
                        foregroundColor: ColorsPalate.onPrimaryColor,
                      ),
                      onPressed: () async {
                        // Get sales from Hive
                        final SaleService saleService = SaleService();
                        final salesList = await saleService.getSalesFromHive();
                        if (salesList.isNotEmpty) {
                          await saleService.postSales(salesList);
                        } else {
                          print("Empty sale list **********************");
                        }
                      },
                      child: Text(
                        'Post Sales to API',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text("data"),
          );
        },
      ),
    );
  }
}
