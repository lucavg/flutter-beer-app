// TODO implement Beer table
import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:drift/drift.dart';

@DataClassName('DbBeer')
class DbBeerTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get rating => integer()();
  TextColumn get thumbImageUrl => text()();
  TextColumn get imageUrl => text()();
  TextColumn get brewery => text().nullable()();
}

extension DbBeerExtension on DbBeer {
  Beer getModel() => Beer(id: id, name: name, rating: rating, thumbImageUrl: thumbImageUrl, imageUrl: imageUrl);
}

extension BeerExtension on Beer {
  DbBeerTableCompanion getDbModel() {
    final id = this.id;

    return DbBeerTableCompanion.insert(id: id, name: name, rating: rating, thumbImageUrl: thumbImageUrl, imageUrl: imageUrl, brewery: Value(brewery?.id));
  }
}
