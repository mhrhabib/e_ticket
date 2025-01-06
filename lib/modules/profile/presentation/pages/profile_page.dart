import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/modules/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: ProfileCubit(getProfileUseCase: sl())..loadProfilesData(),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  Icon(Icons.person_remove_outlined),
                  Text(
                    state.profilesModel.data!.name!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(state.profilesModel.data!.email!),
                  Text(state.profilesModel.data!.mobile!),
                  Text(state.profilesModel.data!.status!),
                ],
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
