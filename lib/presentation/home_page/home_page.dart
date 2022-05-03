import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _userCubit = BlocProvider.of<UserCubit>(context);

  @override
  void dispose() {
    _userCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (_, state) {
            if (state is UserInitial) {
              return const Text('Press the button to load a random user');
            } else if (state is UserLoading) {
              return const CircularProgressIndicator();
            } else if (state is NoUser) {
              return const Text('No user found');
            } else if (state is UserLoaded) {
              final user = state.user;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    user.thumbnailUrl,
                    loadingBuilder: (_, __, chunkEvent) {
                      final percent = (chunkEvent?.cumulativeBytesLoaded ?? 0) /
                          (chunkEvent?.expectedTotalBytes ?? 1);
                      return CircularProgressIndicator(value: percent);
                    },
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  ),
                  Text.rich(
                    TextSpan(
                      text: user.name,
                      children: [TextSpan(text: '\n(${user.email})')],
                    ),
                  ),
                ],
              );
            } else if (state is UserError) {
              return Text(
                state.message,
                style: const TextStyle(fontSize: 30, color: Colors.red),
              );
            } else {
              return const Text('Unknown state');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _userCubit.fetchRandomUser,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
