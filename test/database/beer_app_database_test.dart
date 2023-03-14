import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../di/test_injectable.dart';

void main() {
  late BeerAppDatabase sut;

  setUp(() async {
    await initTestInjectable();
    sut = getIt();
  });

  test('BeerAppDatabase should have the correct version', () {
    expect(sut.schemaVersion, 1);
  });

  test('BeerAppDatabase should delete all tables', () async {
    final resultTodos1 = await sut.select(sut.dbBeerTable).get();
    expect(resultTodos1.isEmpty, true);

    await sut.into(sut.dbBeerTable).insert(DbBeerTableCompanion.insert(id: id, name: name, rating: rating, thumbImageUrl: thumbImageUrl, imageUrl: imageUrl));
    await sut.into(sut.dbBeerTable).insert(DbBeerTableCompanion.insert(id: id, name: name, rating: rating, thumbImageUrl: thumbImageUrl, imageUrl: imageUrl));
    await sut.into(sut.dbBeerTable).insert(DbBeerTableCompanion.insert(id: id, name: name, rating: rating, thumbImageUrl: thumbImageUrl, imageUrl: imageUrl));
    

    final resultTodos2 = await sut.select(sut.dbBeerTable).get();
    expect(resultTodos2.isEmpty, false);
    expect(resultTodos2.length, 3);

    await sut.deleteAllData();

    final resultTodos3 = await sut.select(sut.dbBeerTable).get();
    expect(resultTodos3.isEmpty, true);
  });
}
