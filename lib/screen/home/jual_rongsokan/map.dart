import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lapakberkah77/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:lapakberkah77/blocs/geolocation/geolocation_bloc.dart';
import 'package:lapakberkah77/blocs/place/place_bloc.dart';

class Location extends StatelessWidget {
   const Location({super.key});

  static const String routeName = '/map';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) =>  const Location(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) { 
            return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: BlocBuilder<GeolocationBloc, GeolocationState>(
                    builder: (context, state) {
                  if (state is GeolocationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GeolocationLoaded) {
                    return Gmap(
                      lat: state.position.latitude,
                      lng: state.position.longitude,
                    );
                  } else {
                    return const Text('Something Went Wrong.');
                  }
                }),
              ),
              const LocationAuto(),
              const LoadingButton(),

            ],
          );
          } else if (state is PlaceLoaded){
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Gmap(
                    lat: state.place.lat, 
                    lng: state.place.lon,
                    ),
                ),
                const LocationAuto(),
                LoadedButton(placeName: state.place.name,),
              ],
            );
          }else{
            return const Text('Something Went Wrong');
          }
          
        },
      ),
    );
  }
}

class LocationAuto extends StatelessWidget {
  const LocationAuto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).padding,
      child: Column(
        children: [
          const LocationSearchBox(),
          BlocBuilder<AutocompleteBloc, AutocompleteState>(
            builder: (context, state) {
              if (state is AutocompleteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AutocompleteLoaded) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  height: 300,
                  color: state.autocomplete.isNotEmpty
                      ? Colors.white.withOpacity(0.6)
                      : Colors.transparent,
                  child: ListView.builder(
                      itemCount: state.autocomplete.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.autocomplete[index].description),
                          onTap: () {
                            context.read<PlaceBloc>().add(LoadPlace(placeId:state.autocomplete[index].placeId));
                          },
                        );
                      }),
                );
              } else {
                return const Text('Something Went Wrong!');
              }
            },
          )
        ],
      ),
    );
  }
}

class LoadedButton extends StatelessWidget {
  final String placeName;
  const LoadedButton({
    required this.placeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 70,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed:() => Navigator.pop(context),
            child: const Text('Cancel'),),
            ElevatedButton(
              onPressed: () {
                savePlaceName('address',placeName);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> savePlaceName(String field, String newData) async{
    final userCollection = FirebaseFirestore.instance.collection('Users');
    final currentUser = FirebaseAuth.instance.currentUser!;

    await userCollection.doc(currentUser.email).update({field: newData}); 
  }
  
  
}

class LoadingButton extends StatelessWidget {
 
  const LoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 70,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed:() => Navigator.pop(context),
            child: const Text('Cancel'),),
          ],
        ),
      ),
    );
  }
  
  Future<void> savePlaceName(String field, String newData) async{
    final userCollection = FirebaseFirestore.instance.collection('Users');
    final currentUser = FirebaseAuth.instance.currentUser!;

    await userCollection.doc(currentUser.email).update({field: newData}); 
  }
  
  
}

class Gmap extends StatelessWidget {
  final double lat;
  final double lng;

  const Gmap({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 10),
      myLocationEnabled: true,
      
    );
  }
}

class LocationSearchBox extends StatefulWidget {
  const LocationSearchBox({
    super.key,
  });

  @override
  State<LocationSearchBox> createState() => _LocationSearchBoxState();
}

class _LocationSearchBoxState extends State<LocationSearchBox> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AutocompleteLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Masukan Lokasi',
                  suffixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.only(left: 20, bottom: 5, right: 5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white))),
              onChanged: (value) {
                setState(() {
                  context
                    .read<AutocompleteBloc>()
                    .add(LoadAutoComplete(searchInput: value));
                });
              },
            ),
          );
        } else {
          return const Text('Something Went Wrong');
        }
      },
    );
  }
}
