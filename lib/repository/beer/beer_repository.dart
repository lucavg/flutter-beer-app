import 'package:beer_app/database/beer/beer_dao_storage.dart';
import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/webservice/beer/beer_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
abstract class BeerRepository {
  @factoryMethod
  factory BeerRepository(
      BeerService beerService, BeerDaoStorage beerDaoStorage) = _BeerRepository;

  Stream<List<BeerWithBrewery>> getAllBeers();

  Future<List<Beer>> fetchBeers();

  Future<void> saveBeer(String name);

  Future<void> saveBeerWithValue(Beer beer);

  Future<void> setBeerRating({required String id, required int rating});
}

class _BeerRepository implements BeerRepository {
  final BeerService _beerService;
  final BeerDaoStorage _beerDao;

  _BeerRepository(this._beerService, this._beerDao);

  @override
  Future<List<Beer>> fetchBeers() async {
    final result = await _beerService.getAllBeers();
    for (final beer in result.data) {
      await _beerDao.createBeerWithValue(beer);
    }

    return result.data;
  }

  @override
  Stream<List<BeerWithBrewery>> getAllBeers() => _beerDao.getAllBeersStream();

  @override
  Future<void> saveBeer(String name) async {
    await _beerDao.createBeer(name);
  }

  @override
  Future<void> saveBeerWithValue(Beer beer) async {
    await _beerDao.createBeerWithValue(beer);
  }

  @override
  Future<void> setBeerRating({required String id, required int rating}) async {
    await _beerDao.updateBeer(id: id, rating: rating);
  }
}
