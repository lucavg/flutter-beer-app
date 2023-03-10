import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/model/database/beer/db_brewery_table.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'brewery_dao_storage.g.dart';

@lazySingleton
abstract class BreweryDaoStorage {
  @factoryMethod
  factory BreweryDaoStorage(BeerAppDatabase db) = _BreweryDaoStorage;

  Stream<List<Brewery>> getAllBreweriesStream();

  Future<List<DbBrewery>> getAllBreweries();

  Future<void> createBrewery(String id, String name);

  Future<void> createBreweryWithValue(Brewery brewery);
}

@DriftAccessor(tables: [
  DbBreweryTable,
])
class _BreweryDaoStorage extends DatabaseAccessor<BeerAppDatabase> with _$_BreweryDaoStorageMixin implements BreweryDaoStorage {
  _BreweryDaoStorage(super.db);

  @override
  Future<void> createBrewery(String id, String name) => into(db.dbBreweryTable).insert(DbBreweryTableCompanion.insert(id: id, name: name, address: "", city: "", country: ""));

  @override
  Future<void> createBreweryWithValue(Brewery brewery) async =>
      into(db.dbBreweryTable).insert(DbBreweryTableCompanion.insert(id: brewery.id, name: brewery.name, address: brewery.address, city: brewery.city, country: brewery.country));

  @override
  Future<List<DbBrewery>> getAllBreweries() => select(db.dbBreweryTable).get();

  @override
  Stream<List<Brewery>> getAllBreweriesStream() => select(db.dbBreweryTable).watch().map((event) => event.map((e) => e.getModel()).toList());
}
