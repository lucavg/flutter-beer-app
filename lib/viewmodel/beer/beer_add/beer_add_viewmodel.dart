import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/repository/brewery/brewery_repository.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'dart:math';

@injectable
class BeerAddViewModel with ChangeNotifierEx {
  final BeerRepository _beerRepository;
  final BreweryRepository _breweryRepository;
  final MainNavigator _navigator;
  Beer _beer =
      const Beer(id: "", name: "", rating: 0, thumbImageUrl: "", imageUrl: "");
  Brewery? _selectedBrewery;
  String? _beerName;
  int? _beerRating;
  String? _beerThumbImageUrl;
  String? _beerImageUrl;
  String? _breweryId;
  String? _breweryName;
  String? _breweryAddress;
  String? _breweryCity;
  String? _breweryCountry;
  final String _dropdownHint = "Select a brewery";

  late Stream<List<Brewery>> _breweryStream;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  Stream<List<Brewery>> get dataBreweryStream => _breweryStream;

  String get breweryId => _breweryId.toString();

  Brewery? get selectedBrewery => _selectedBrewery;

  String get dropdownHint => _dropdownHint.toString();

  bool get isSaveEnabled => true;

  set selectedBrewery(Brewery? brewery) {
    _selectedBrewery = brewery;
    notifyListeners();
  }

  BeerAddViewModel(
    this._beerRepository,
    this._breweryRepository,
    this._navigator,
  );

  Future<void> init() async {
    _breweryStream = _breweryRepository.getAllBreweries().asBroadcastStream();
  }

  void onNameChanged(String beerName) {
    _beerName = beerName.trim();
    logger.error(_beerName.toString());
    notifyListeners();
  }

  void onRatingChanged(String beerRating) {
    if (beerRating.isNotEmpty) {
      _beerRating = int.parse(beerRating);
    }
    notifyListeners();
  }

  void onThumbImageUrlChanged(String beerThumbImageUrl) {
    _beerThumbImageUrl = beerThumbImageUrl.trim();
    notifyListeners();
  }

  void onImageUrlChanged(String beerImageUrl) {
    _beerImageUrl = beerImageUrl.trim();
    notifyListeners();
  }

  void onBreweryIdChanged(String breweryId) {
    _breweryId = breweryId.trim();
    // onBreweryChanged(breweryId);
    notifyListeners();
  }

  void onBreweryNameChanged(String breweryName) {
    _breweryName = breweryName.trim();
    notifyListeners();
  }

  void onBreweryAddressChanged(String breweryAddress) {
    _breweryAddress = breweryAddress.trim();
    notifyListeners();
  }

  void onBreweryCityChanged(String breweryCity) {
    _breweryCity = breweryCity.trim();
    notifyListeners();
  }

  void onBreweryCountryChanged(String breweryCountry) {
    _breweryName = breweryCountry.trim();
    notifyListeners();
  }

  void onBackClicked() => _navigator.goBack<void>();

  Future<void> onSaveClicked() async {
    final Brewery brewery = Brewery(
        id: getRandomString(10),
        name: _breweryName.toString(),
        address: _breweryAddress.toString(),
        city: _breweryCity.toString(),
        country: _breweryCountry.toString());
    await _breweryRepository.saveBreweryWithValue(brewery);
    _beer = Beer(
        id: getRandomString(10),
        name: _beerName.toString(),
        rating: _beerRating?.toInt() ?? 0,
        thumbImageUrl: _beerThumbImageUrl.toString(),
        imageUrl: _beerImageUrl.toString(),
        brewery: brewery);
    await _beerRepository.saveBeerWithValue(_beer);
    _navigator.goBack(result: true);
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
