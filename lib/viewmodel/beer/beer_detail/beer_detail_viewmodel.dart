import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:geocoding/geocoding.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class BeerDetailViewModel with ChangeNotifierEx {
  late final BeerWithBrewery _beerWithBrewery;
  final BeerRepository _beerRepository;
  final MainNavigator _navigator;
  final SharedPreferences _sharedPreferences;

  BeerDetailViewModel(
    this._beerRepository,
    this._navigator,
    this._sharedPreferences,
  );

  String? _errorKey;
  bool _hasImage = false;
  bool _isEnlarged = false;
  double _lat = 0.0;
  double _lng = 0.0;

  bool _ratingUpdated = false;
  late int _currentRating;
  var _isLoading = false;

  String? get errorKey => _errorKey;

  bool get isLoading => _isLoading;

  bool get isEnlarged => _isEnlarged;

  bool get hasImage => _hasImage;

  double get lat => _lat;

  double get lng => _lng;

  bool get ratingUpdated => _ratingUpdated;

  int get currentRating => _currentRating;

  BeerWithBrewery get beerWithBrewery => _beerWithBrewery;

  Future<void> init(BeerWithBrewery beerWithBrewery) async {
    _beerWithBrewery = beerWithBrewery;
    try {
      if (_beerWithBrewery.beer.imageUrl.isNotEmpty) {
        _hasImage = true;
      } else {
        _hasImage = false;
      }

      _currentRating = beerWithBrewery.beer.rating;

      final String address =
          "${_beerWithBrewery.brewery!.address}, ${_beerWithBrewery.brewery!.city}, ${_beerWithBrewery.brewery!.country}";
      final List<Location> locations = await locationFromAddress(address);
      final first = locations.first;
      _lat = first.latitude;
      _lng = first.longitude;
      _isLoading = true;
      _errorKey = null;
    } catch (e, stack) {
      logger.error('failed to get brewery location', error: e, trace: stack);
      if (e is LocalizedError) {
        _errorKey = e.getLocalizedKey();
      } else {
        _errorKey = LocalizationKeys.errorGeneral;
      }
    } finally {
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
