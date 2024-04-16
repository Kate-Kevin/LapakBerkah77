import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lapakberkah77/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:lapakberkah77/blocs/basket/basket_bloc.dart';
import 'package:lapakberkah77/blocs/geolocation/geolocation_bloc.dart';
import 'package:lapakberkah77/blocs/place/place_bloc.dart';
import 'package:lapakberkah77/repositories/geolocation/geolocation_repositories.dart';
import 'package:lapakberkah77/repositories/places/places_repositories.dart';
import 'package:lapakberkah77/services/app_router.dart';
import 'package:lapakberkah77/shared/splash.dart';
import 'package:lapakberkah77/shared/theme.dart';




Future<void> main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepositories>(
          create: (_)=> GeolocationRepositories(),
          ),
        RepositoryProvider<PlaceRepository>(
          create: (_)=> PlaceRepository(),
          ),
      ], 
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => GeolocationBloc(
            geolocationRepositories: context.read<GeolocationRepositories>()
            )..add(LoadGeolocation())
          )),
          BlocProvider(create: ((context) => AutocompleteBloc(
            placeRepository: context.read<PlaceRepository>()
            )..add(const LoadAutoComplete())
          )),
          BlocProvider(create: ((context) => PlaceBloc(
            placesRepository: context.read<PlaceRepository>()
            )
          )),
          BlocProvider(
            create: (context) => BasketBloc()..add(StartBasket())
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: const SplashPage(),
        ),
      )
      );
  }
}

