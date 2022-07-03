import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtobe_demo/home/bloc/home_bloc.dart';
import 'package:youtobe_demo/services/boredService.dart';

import '../services/connectivityService.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Activities for bored people"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Column(
                children: [
                  Text(state.activityName),
                  Text(state.activityType),
                  Text(state.participants.toString()),
                  ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context)
                          .add(LoadApiEvent()),
                      child: Text("RELOAD API")),
                ],
              );
            }
            if(state is HomeNoInternetState){
              return Text("no internet :)");
            }
            return Container();
          },
        ),
      ),
    );
  }
}
