import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:geocoding/geocoding.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class BeerDetailViewModel with ChangeNotifierEx {
  late final BeerWithBrewery _beerWithBrewery;
  final MainNavigator _navigator;
  final SharedPreferences _sharedPreferences;

  BeerDetailViewModel(
    this._navigator,
    this._sharedPreferences,
  );

  String? _errorKey;
  bool _hasImage = false;
  double _lat = 0.0;
  double _lng = 0.0;
  var _isLoading = false;

  String? get errorKey => _errorKey;

  bool get isLoading => _isLoading;

  bool get hasImage => _hasImage;

  double get lat => _lat;

  double get lng => _lng;

  BeerWithBrewery get beerWithBrewery => _beerWithBrewery;

  Future<void> init(BeerWithBrewery beerWithBrewery) async {
    _beerWithBrewery = beerWithBrewery;
    try {
      if (_beerWithBrewery.beer.imageUrl.isNotEmpty) {
        _hasImage = true;
      } else {
        _hasImage = false;
      }
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
      logger.error(_lat.toString());
      logger.error(_lng.toString());
      notifyListeners();
    }
  }

  void onLogoutClicked() =>
      {_sharedPreferences.clear(), _navigator.goToSplash()};
}
