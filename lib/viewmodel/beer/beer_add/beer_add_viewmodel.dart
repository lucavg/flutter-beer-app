import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/repository/brewery/brewery_repository.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'dart:math';

@injectable
class BeerAddViewModel with ChangeNotifierEx {
  final BeerRepository _beerRepository;
  final BreweryRepository _breweryRepository;
  final MainNavigator _navigator;
  final storage = FirebaseStorage.instance.ref();

  Brewery? _selectedBrewery;
  String? _beerName;
  int? _beerRating;
  String? _beerThumbImageUrl;
  String? _beerImageUrl;
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
    _breweryCountry = breweryCountry.trim();
    notifyListeners();
  }

  void resetForm() {
    _breweryName = "";
    _breweryCountry = "";
    _breweryCity = "";
    _breweryAddress = "";

    _beerName = "";
    _beerImageUrl = "";
    _beerThumbImageUrl = "";
    _beerRating = 0;
  }

  void onBackClicked() => _navigator.goBack<void>();

  Future<void> onBreweryExistsSaveClicked() async {
    final beerImageRef = storage.child("${_beerName}_image");
    final Beer beer = Beer(
        id: getRandomString(10),
        name: _beerName.toString(),
        rating: _beerRating?.toInt() ?? 0,
        thumbImageUrl: _beerThumbImageUrl.toString(),
        imageUrl: _beerImageUrl.toString(),
        brewery: _selectedBrewery);
    await _beerRepository.saveBeerWithValue(beer);
    _navigator.goBack(result: true);
  }

  Future<void> onNewBrewerySavedClicked() async {
    final Brewery brewery = Brewery(
        id: getRandomString(10),
        name: _breweryName.toString(),
        address: _breweryAddress.toString(),
        city: _breweryCity.toString(),
        country: _breweryCountry.toString());
    await _breweryRepository.saveBreweryWithValue(brewery);
    final Beer beer = Beer(
        id: getRandomString(10),
        name: _beerName.toString(),
        rating: _beerRating?.toInt() ?? 0,
        thumbImageUrl: _beerThumbImageUrl.toString(),
        imageUrl: _beerImageUrl.toString(),
        brewery: brewery);
    await _beerRepository.saveBeerWithValue(beer);
    _navigator.goBack(result: true);
  }

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}
