import 'package:beer_app/database/brewery/brewery_dao_storage.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/webservice/brewery/brewery_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
abstract class BreweryRepository {
  @factoryMethod
  factory BreweryRepository(BreweryService breweryService, BreweryDaoStorage breweryDaoStorage) = _BreweryRepository;

  Stream<List<Brewery>> getAllBreweries();
  Future<List<Brewery>> fetchBreweries();
  Future<void> saveBrewery(String id, String name);
}

class _BreweryRepository implements BreweryRepository {
  final BreweryService _breweryService;
  final BreweryDaoStorage _breweryDao;

  _BreweryRepository(this._breweryService, this._breweryDao);

  @override
  Future<List<Brewery>> fetchBreweries() async {
    final result = await _breweryService.getAllBreweries();
    for (final brewery in result.data) {
      await _breweryDao.createBreweryWithValue(brewery);
    }

    return result.data;
  }

  @override
  // TODO: implement getAllBeers
  Stream<List<Brewery>> getAllBreweries() => _breweryDao.getAllBreweriesStream();

  @override
  Future<void> saveBrewery(String id, String name) async {
    // TODO: implement saveBeer
    await _breweryDao.createBrewery(id, name);
  }
}
