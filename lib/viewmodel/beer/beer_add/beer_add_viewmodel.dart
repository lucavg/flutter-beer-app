import 'dart:io';

import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/repository/brewery/brewery_repository.dart';
import 'package:flutter/material.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'dart:math';

import 'package:path/path.dart';

@injectable
class BeerAddViewModel with ChangeNotifierEx {
  final BeerRepository _beerRepository;
  final BreweryRepository _breweryRepository;
  final MainNavigator _navigator;
  final storage = FirebaseStorage.instance.ref();

  Brewery? _selectedBrewery;
  String? _beerName;
  int _beerRating = 0;
  File? _beerImage;
  String? _breweryName;
  String? _breweryAddress;
  String? _breweryCity;
  String? _breweryCountry;

  final TextEditingController beerNameController = TextEditingController();
  final TextEditingController beerRatingController = TextEditingController();
  final TextEditingController breweryNameController = TextEditingController();
  final TextEditingController breweryAddressController =
      TextEditingController();
  final TextEditingController breweryCityController = TextEditingController();
  final TextEditingController breweryCountryController =
      TextEditingController();

  final String _dropdownHint = "Select a brewery";

  late Stream<List<Brewery>> _breweryStream;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  Stream<List<Brewery>> get dataBreweryStream => _breweryStream;

  Brewery? get selectedBrewery => _selectedBrewery;

  String get dropdownHint => _dropdownHint.toString();

  int get currentRating => _beerRating;

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

  void onRatingChanged(int beerRating) {
    _beerRating = beerRating;
    notifyListeners();
  }

  void onImageUrlChanged(File? beerImage) {
    _beerImage = beerImage;
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
    _selectedBrewery = null;

    _beerName = "";
    _beerImage = null;
    _beerRating = 0;

    breweryNameController.clear();
    breweryCountryController.clear();
    breweryCityController.clear();
    breweryAddressController.clear();

    beerNameController.clear();
    beerRatingController.clear();

    notifyListeners();
    _breweryStream = _breweryRepository.getAllBreweries().asBroadcastStream();
  }

  void onBackClicked() => _navigator.goBack<void>();

  Future<void> onBreweryExistsSaveClicked() async {
    final String imageUrl = await uploadFile(_beerImage!);
    final Beer beer = Beer(
        id: getRandomString(10),
        name: _beerName.toString(),
        rating: _beerRating?.toInt() ?? 0,
        thumbImageUrl: imageUrl.toString(),
        imageUrl: imageUrl.toString(),
        brewery: _selectedBrewery);
    await _beerRepository.saveBeerWithValue(beer);
    _navigator.goBack(result: true);
  }

  Future<void> onNewBrewerySavedClicked() async {
    final String imageUrl = await uploadFile(_beerImage!);
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
        thumbImageUrl: imageUrl,
        imageUrl: imageUrl,
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

  Future<String> uploadFile(File image) async {
    try {
      final rng = Random();
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("${_beerName}_${rng.nextInt(9999999)}.jpg");

      final File selectedImagePath = File(image.path);
      final metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      final uploadTask = imageRef.putFile(selectedImagePath, metadata);
      final String imageUrl = await uploadTask.then((snapshot) async {
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl.toString();
      });

      return imageUrl;
    } on FirebaseException catch (e) {
      logger.error("A FirebaseError has occurred.", error: e);
      return "";
    }
  }
}
