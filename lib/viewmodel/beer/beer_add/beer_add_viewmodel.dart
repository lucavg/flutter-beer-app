import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/beer/beer_repository.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

@injectable
class BeerAddViewModel with ChangeNotifierEx {
  final BeerRepository _beerRepository;
  final MainNavigator _navigator;
  String? _beer;

  BeerAddViewModel(
      this._beerRepository,
      this._navigator,
      );

  bool get isSaveEnabled => _beer?.isNotEmpty == true;

  void onBeerChanged(String beer) {
    _beer = beer.trim();
    notifyListeners();
  }

  void onBackClicked() => _navigator.goBack<void>();

  Future<void> onSaveClicked() async {
    final beer = _beer;
    if (beer == null) {
      return _navigator.showError('Beer should not be empty');
    }
    await _beerRepository.saveBeer(beer);
    _navigator.goBack(result: true);
  }
}
