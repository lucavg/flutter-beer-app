import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:beer_app/repository/brewery/brewery_repository.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:beer_app/widget/beer/beer_item.dart';
import 'package:flutter/material.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable // This annotation is used by the dependency injection library, it tells the library that this class can be injected, but isn't a singleton.
class BeersOverViewViewModel with ChangeNotifierEx {
  // ChangeNotifierEx is a custom class that extends ChangeNotifier. A ChangeNotifier is a class that notifies listeners when a value changes. This means that the UI will be rebuild when we call `notifyListeners();`.
  final BeerRepository _beerRepository;
  final BreweryRepository _breweryRepository;
  final MainNavigator _navigator;
  final SharedPreferences _sharedPreferences;

  late Stream<List<BeerWithBrewery>> _beerStream;
  late Stream<List<Brewery>> _breweryStream;

  var _isLoading = false;
  var _isGridView = false;
  String? _errorKey;

  bool get isLoading => _isLoading;

  bool get isGridView => _isGridView;

  String? get errorKey => _errorKey;

  Stream<List<BeerWithBrewery>> get dataBeerStream => _beerStream;

  Stream<List<Brewery>> get dataBreweryStream => _breweryStream;

  MainNavigator get navigator => _navigator;

  BeersOverViewViewModel(this._beerRepository, this._breweryRepository,
      this._navigator, this._sharedPreferences);

  Future<void> init() async {
    _beerStream = _beerRepository.getAllBeers();
    _breweryStream = _breweryRepository.getAllBreweries();
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

  Future<void> onBeerRated({required String id, required int rating}) async {
    if (id == "") return;
    await _beerRepository.setBeerRating(id: id, rating: rating);
  }

  void onAddClicked() => _navigator.goToAddBeer();

  void onLogoutClicked() =>
      {_sharedPreferences.clear(), _navigator.goToSplash()};

  void onBeerClicked(BeerWithBrewery beer) => _navigator.goToBeerDetail(beer);

  void onViewToggleClicked() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  Widget buildListView(List<BeerWithBrewery?> data, MainNavigator navigator,
      BeerAppTheme theme) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return BeerItem(
          beerWithBrewery: item!,
          navigator: navigator,
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeDimens.padding16),
        child: Container(
          height: 1,
          color: theme.colorsTheme.primary.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget buildGridView(List<BeerWithBrewery?> data, MainNavigator navigator) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          child: Center(
            child: GestureDetector(
              onTap: () => navigator.goToBeerDetail(item),
              child: Image.network(item!.beer.imageUrl),
            ),
          ),
        );
      },
    );
  }
}
