import 'dart:collection';

import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/model/webservice/beer/group_option.dart';
import 'package:beer_app/model/webservice/beer/sort_option.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/repository/brewery/brewery_repository.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:beer_app/widget/beer/beer_grid_item.dart';
import 'package:beer_app/widget/beer/beer_item.dart';
import 'package:flutter/material.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class BeersOverViewViewModel with ChangeNotifierEx {
  final BeerRepository _beerRepository;
  final BreweryRepository _breweryRepository;
  final MainNavigator _navigator;
  final SharedPreferences _sharedPreferences;

  late Stream<List<BeerWithBrewery>> _beerStream;
  late Stream<List<Brewery>> _breweryStream;

  SortOption _sortOption = SortOption.NAMEASCENDING;
  GroupOption _groupOption = GroupOption.NONE;
  var _isLoading = false;
  var _isGridView = false;

  String? _errorKey;

  bool get isLoading => _isLoading;

  bool get isGridView => _isGridView;

  String? get errorKey => _errorKey;

  Stream<List<BeerWithBrewery>> get dataBeerStream => _beerStream;

  Stream<List<Brewery>> get dataBreweryStream => _breweryStream;

  MainNavigator get navigator => _navigator;

  SortOption get sortOption => _sortOption;

  GroupOption get groupOption => _groupOption;

  BeersOverViewViewModel(this._beerRepository, this._breweryRepository,
      this._navigator, this._sharedPreferences);

  Future<void> init() async {
    _beerStream = _beerRepository.getAllBeers();
    _breweryStream = _breweryRepository.getAllBreweries();
    try {
      _isLoading = true;
      _errorKey = null;
      notifyListeners();
      await _breweryRepository.fetchBreweries();
      await _beerRepository.fetchBeers();
    } catch (e, stack) {
      logger.error('failed to get beers', error: e, trace: stack);
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

  Future<void> onDownloadClicked() async {
    try {
      _isLoading = true;
      _errorKey = null;
      notifyListeners();
      await _breweryRepository.fetchBreweries();
      await _beerRepository.fetchBeers();
    } catch (e, stack) {
      logger.error('failed to get beers', error: e, trace: stack);
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

  void onAddClicked() => _navigator.goToAddBeer();

  void onLogoutClicked() =>
      {_sharedPreferences.clear(), _navigator.goToSplash()};

  void onBeerClicked(BeerWithBrewery beer) => _navigator.goToBeerDetail(beer);

  void onViewToggleClicked() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void onSortingOptionChanged(SortOption sortOption) {
    _sortOption = sortOption;
    notifyListeners();
  }

  void onGroupOptionChanged(GroupOption groupOption) {
    _groupOption = groupOption;
    notifyListeners();
  }
}
