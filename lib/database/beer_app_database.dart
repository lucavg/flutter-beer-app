import 'package:beer_app/model/database/beer/db_beer_table.dart';
import 'package:beer_app/model/database/beer/db_brewery_table.dart';
import 'package:drift/drift.dart';


part 'beer_app_database.g.dart';

@DriftDatabase(tables: [
  DbBeerTable,
  DbBreweryTable
])
class BeerAppDatabase extends _$BeerAppDatabase {
  BeerAppDatabase(super.db);

  BeerAppDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;

  Future<void> deleteAllData() {
    return transaction(() async {
      for (final table in allTables) {
        await delete<Table, dynamic>(table).go();
      }
    });
  }
}