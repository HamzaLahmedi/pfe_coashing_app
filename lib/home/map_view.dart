import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_coashing_app/models/gym.dart';
import 'package:pfe_coashing_app/services/gym_services.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng? currentLocation;
  List<Gym> gyms = [];
  final GymsService _gymService = GymsService();
  //final BookingService _bookingService = BookingService();
  DateTime? _selectedDate;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _loadGyms();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       _goToMyLocation();
    });
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  Future<void> _goToMyLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition();
      print("\n\nposition: $position\n\n");
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
      mapController.move(currentLocation!, 2); // Poisitional arguments
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _loadGyms() async {
    try {
      final loadedGyms = await _gymService.fetchGyms();
    
      gyms = loadedGyms;
      print("loadedddddddddddddddd gyms: ${loadedGyms.length}");
    
      setState(() => print("updated"));

    } catch (e) {
      print('Error loading gyms: $e');
    }
  }

  void _showGymDetails(Gym gym) {
    print("*******************************************");
    
    print("Gym Name: ${gym.name}");
    print("Gym Description: ${gym.description}");
    
    print("*******************************************");
    showDialog(
      barrierColor: Colors.black.withValues(alpha: 0.8),
      context: context,
      builder: (context) => AlertDialog(
        title: Text(gym.name),
        content: Text(gym.description ?? 'No description available'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () => {
             // _showBookingDialog(gym)
            },
            child: Text('Contact'),
          ),
        ],
      ),
    );
  }

  /*void _showBookingDialog(Gym gym) {
    showDialog(
      context: context,
      builder: (context) => BookingDialog(
        gym: gym,
         bookingService: _bookingService(),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gyms Map')),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(

         initialCenter: LatLng(0, 0),
         initialZoom: 2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            tileProvider: NetworkTileProvider(),
            maxZoom: 19,
            keepBuffer: 5,
          ),
          MarkerLayer(
            markers: [
              
              if (currentLocation != null)
                  Marker(
                  point: currentLocation!,
                  width: 80,
                  height: 80,
                  child: Icon(Icons.my_location_rounded, color: Colors.blue, size: 40),
                ),
              // Add markers for complexes
              ...gyms.map(
                (gym) => Marker(
                  point: LatLng(gym.lat, gym.long),
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: () => _showGymDetails(gym),
                    child: Tooltip(
                      message: '${gym.name}\n${gym.description ?? ""}',
                      child: Icon(Icons.location_on_sharp, color: Colors.red, size: 50),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToMyLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
