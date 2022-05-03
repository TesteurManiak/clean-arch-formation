import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch_formation/domain/entities/user.dart';
import 'package:clean_arch_formation/presentation/blocs/user/user_cubit.dart';
import 'package:clean_arch_formation/presentation/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/fixture.dart';
import '../../utils/mock_http_client.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

const _thumbnailUrl = 'https://randomuser.me/api/portraits/thumb/';

void main() {
  late MockUserCubit mockUserCubit;

  setUp(() async {
    registerFallbackValue(Uri());

    // Load an image from assets and transform it from bytes to List<int>
    final imageByteData = await fixtureAsBytes('thumbnail.jpeg');
    final imageIntList = imageByteData.buffer.asInt8List();

    final requestsMap = {
      Uri.parse(_thumbnailUrl): imageIntList,
    };

    HttpOverrides.global = MockHttpOverrides(requestsMap);
    mockUserCubit = MockUserCubit();
  });

  group('MyHomePage', () {
    const tUser = User(
      id: '1',
      name: 'John Doe',
      email: 'johndoe@example.com',
      thumbnailUrl: _thumbnailUrl,
    );

    testWidgets('initial state', (tester) async {
      // arrange
      when(() => mockUserCubit.state).thenReturn(const UserInitial());

      // act
      await tester
          .pumpWidget(_buildTestableWidget<UserCubit>(bloc: mockUserCubit));

      // assert
      expect(mockUserCubit.state, isA<UserInitial>());
      expect(
        find.text('Press the button to load a random user'),
        findsOneWidget,
      );
    });

    testWidgets('loading state', (tester) async {
      // arrange
      when(() => mockUserCubit.state).thenReturn(const UserLoading());

      // act
      await tester
          .pumpWidget(_buildTestableWidget<UserCubit>(bloc: mockUserCubit));
      for (int i = 0; i < 10; i++) {
        await tester.pump();
      }

      // assert
      expect(mockUserCubit.state, isA<UserLoading>());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('no user state', (tester) async {
      // arrange
      when(() => mockUserCubit.state).thenReturn(const NoUser());

      // act
      await tester
          .pumpWidget(_buildTestableWidget<UserCubit>(bloc: mockUserCubit));

      // assert
      expect(mockUserCubit.state, isA<NoUser>());
      expect(find.text('No user found'), findsOneWidget);
    });

    testWidgets('user loaded state', (tester) async {
      // arrange
      when(() => mockUserCubit.state).thenReturn(const UserLoaded(user: tUser));

      // act
      await tester
          .pumpWidget(_buildTestableWidget<UserCubit>(bloc: mockUserCubit));

      // assert
      expect(mockUserCubit.state, isA<UserLoaded>());
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('${tUser.name}\n(${tUser.email})'), findsOneWidget);
    });

    testWidgets('user error state', (tester) async {
      // arrange
      when(() => mockUserCubit.state)
          .thenReturn(const UserError(message: 'error'));

      // act
      await tester
          .pumpWidget(_buildTestableWidget<UserCubit>(bloc: mockUserCubit));

      // assert
      expect(mockUserCubit.state, isA<UserError>());
      expect(find.text('error'), findsOneWidget);
    });

    testWidgets(
      'pressing refresh button calls fetchRandomUser',
      (tester) async {
        // arrange
        when(() => mockUserCubit.state).thenReturn(const UserInitial());
        when(mockUserCubit.fetchRandomUser).thenAnswer((_) async {});

        // act
        await tester
            .pumpWidget(_buildTestableWidget<UserCubit>(bloc: mockUserCubit));
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();

        // assert
        verify(mockUserCubit.fetchRandomUser);
      },
    );
  });
}

Widget _buildTestableWidget<T extends BlocBase>({required T bloc}) {
  return MaterialApp(
    home: BlocProvider(
      create: (_) => bloc,
      child: const MyHomePage(),
    ),
  );
}
