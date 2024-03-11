import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_test/bloc/location_cubit.dart';
import 'package:flutter_map_test/bloc/object_post_cubit.dart';
import 'package:flutter_map_test/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit()..getLocation(),
        ),
        BlocProvider<ObjectPostCubit>(
          create: (context) => ObjectPostCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Aurora Map App',
        theme: ThemeData(
          //App Bar color
          primaryColor: const Color(0xFF334257),
          colorScheme: const ColorScheme.light().copyWith(
            //Text Field color
            primary: const Color(0xFF548CA8),
            //Floating action button
            secondary: const Color(0xFF96BAFF),
          ),
        ),
        home: MapScreen(),
      ),
    );
  }
}
