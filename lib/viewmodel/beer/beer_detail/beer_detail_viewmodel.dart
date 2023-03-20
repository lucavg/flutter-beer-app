import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class BeerDetailViewModel with ChangeNotifierEx {
  late final BeerWithBrewery _beerWithBrewery;
  final BeerRepository _beerRepository;
  final MainNavigator _navigator;
  final MapController _mapController = MapController();
  final SharedPreferences _sharedPreferences;

  BeerDetailViewModel(
    this._beerRepository,
    this._navigator,
    this._sharedPreferences,
  );

  String? _errorKey;
  bool _isEnlarged = false;

  LatLng _latLng = LatLng(0.0, 0.0);

  bool _ratingUpdated = false;
  late int _currentRating;
  var _isLoading = false;

  String? get errorKey => _errorKey;

  bool get isLoading => _isLoading;

  bool get isEnlarged => _isEnlarged;

  LatLng get latLng => _latLng;

  bool get ratingUpdated => _ratingUpdated;

  int get currentRating => _currentRating;

  BeerWithBrewery get beerWithBrewery => _beerWithBrewery;

  MapController get mapController => _mapController;

  Future<void> init(BeerWithBrewery beerWithBrewery) async {
    _beerWithBrewery = beerWithBrewery;
    try {
      _currentRating = beerWithBrewery.beer.rating;

      final String address =
          "${_beerWithBrewery.brewery!.address}, ${_beerWithBrewery.brewery!.city}, ${_beerWithBrewery.brewery!.country}";
      final List<Location> locations = await locationFromAddress(address);
      final first = locations.first;
      final double lat = first.latitude;
      final double lng = first.longitude;
      _latLng = LatLng(lat, lng);
      mapController.move(_latLng, 15);
      _isLoading = true;
      _errorKey = null;
    } catch (e, stack) {
      logger.error('Failed to get brewery location', error: e, trace: stack);
      if (e is LocalizedError) {
        _errorKey = e.getLocalizedKey();
      } else {
        _errorKey = LocalizationKeys.errorGeneral;
      }
    } finally {
      logger.error("${_latLng.longitude}");
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateRating(int newRating) {
    _currentRating = newRating;
    _ratingUpdated = true;
    notifyListeners();
  }

  void toggleImageZoom() {
    _isEnlarged = !_isEnlarged;
    notifyListeners();
  }

  Future<void> updateBeer() async => await _beerRepository.setBeerRating(
      id: beerWithBrewery.beer.id, rating: _currentRating);

  void onLogoutClicked() =>
      {_sharedPreferences.clear(), _navigator.goToSplash()};
}
