// TODO implement Beer table
import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:drift/drift.dart';

@DataClassName('DbBrewery')
class DbBreweryTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get country => text()();
}

extension DbBreweryExtension on DbBrewery {
  Brewery getModel() => Brewery(id: id, name: name, address: address, city: city, country: country);
}

extension BreweryExtension on Brewery {
  DbBreweryTableCompanion getDbModel() {
    final id = this.id;
    return DbBreweryTableCompanion.insert(id: id, name: name, address: address, city: city, country: country);
  }
}
