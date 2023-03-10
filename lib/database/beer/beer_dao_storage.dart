import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/model/database/beer/db_beer_table.dart';
import 'package:beer_app/model/database/brewery/db_brewery_table.dart';
import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'beer_dao_storage.g.dart';

@lazySingleton
abstract class BeerDaoStorage {
  @factoryMethod
  factory BeerDaoStorage(BeerAppDatabase db) = _BeerDaoStorage;

  Stream<List<BeerWithBrewery>> getAllBeersStream();

  Future<List<DbBeer>> getAllBeers();

  Future<void> createBeer(String name);

  Future<void> createBeerWithValue(Beer beer);

  Future<void> updateBeer({required String id, required int rating});
}

@DriftAccessor(tables: [
  DbBeerTable,
])
class _BeerDaoStorage extends DatabaseAccessor<BeerAppDatabase>
    with _$_BeerDaoStorageMixin
    implements BeerDaoStorage {
  _BeerDaoStorage(super.db);

  @override
  Future<void> createBeer(String name) =>
      into(db.dbBeerTable).insert(DbBeerTableCompanion.insert(
          id: "",
          name: name,
          rating: 0,
          thumbImageUrl: "",
          imageUrl: "",
          brewery: const Value("")));

  @override
  Future<void> createBeerWithValue(Beer beer) async => {
        // into(db.dbBreweryTable)
        //     .insert(DbBreweryTableCompanion.insert(id: beer.brewery!.id, name: beer.brewery!.name, address: beer.brewery!.address, city: beer.brewery!.city, country: beer.brewery!.country)),
        into(db.dbBeerTable).insert(DbBeerTableCompanion.insert(
            id: beer.id,
            name: beer.name,
            rating: beer.rating,
            thumbImageUrl: beer.thumbImageUrl,
            imageUrl: beer.imageUrl,
            brewery: Value(beer.brewery?.id)))
      };

  @override
  Future<List<DbBeer>> getAllBeers() => select(db.dbBeerTable).get();

  // @override
  // Stream<List<Beer>> getAllBeersStream() => select(db.dbBeerTable).watch().map((event) => event.map((e) => e.getModel()).toList());

  @override
  Stream<List<BeerWithBrewery>> getAllBeersStream() {
    final query = select(db.dbBeerTable).join([
      leftOuterJoin(db.dbBreweryTable,
          db.dbBreweryTable.id.equalsExp(db.dbBeerTable.brewery)),
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return BeerWithBrewery(
          beer: row.readTable(db.dbBeerTable).getModel(),
          brewery: row.readTable(db.dbBreweryTable).getModel(),
        );
      }).toList();
    });
  }

  @override
  Future<void> updateBeer({required String id, required int rating}) =>
      (update(db.dbBeerTable)..where((beer) => beer.id.equals(id)))
          .write(DbBeerTableCompanion(rating: Value(rating)));
}
