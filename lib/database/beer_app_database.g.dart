// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_app_database.dart';

// ignore_for_file: type=lint
class $DbTodoTableTable extends DbTodoTable
    with TableInfo<$DbTodoTableTable, DbTodo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbTodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed =
      GeneratedColumn<bool>('completed', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("completed" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [id, title, completed];
  @override
  String get aliasedName => _alias ?? 'db_todo_table';
  @override
  String get actualTableName => 'db_todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbTodo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbTodo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbTodo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
    );
  }

  @override
  $DbTodoTableTable createAlias(String alias) {
    return $DbTodoTableTable(attachedDatabase, alias);
  }
}

class DbTodo extends DataClass implements Insertable<DbTodo> {
  final int id;
  final String title;
  final bool completed;
  const DbTodo(
      {required this.id, required this.title, required this.completed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  DbTodoTableCompanion toCompanion(bool nullToAbsent) {
    return DbTodoTableCompanion(
      id: Value(id),
      title: Value(title),
      completed: Value(completed),
    );
  }

  factory DbTodo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbTodo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  DbTodo copyWith({int? id, String? title, bool? completed}) => DbTodo(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('DbTodo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbTodo &&
          other.id == this.id &&
          other.title == this.title &&
          other.completed == this.completed);
}

class DbTodoTableCompanion extends UpdateCompanion<DbTodo> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> completed;
  const DbTodoTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
  });
  DbTodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required bool completed,
  })  : title = Value(title),
        completed = Value(completed);
  static Insertable<DbTodo> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
    });
  }

  DbTodoTableCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<bool>? completed}) {
    return DbTodoTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbTodoTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $DbBeerTableTable extends DbBeerTable
    with TableInfo<$DbBeerTableTable, DbBeer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBeerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _thumbImageUrlMeta =
      const VerificationMeta('thumbImageUrl');
  @override
  late final GeneratedColumn<String> thumbImageUrl = GeneratedColumn<String>(
      'thumb_image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _breweryMeta =
      const VerificationMeta('brewery');
  @override
  late final GeneratedColumn<String> brewery = GeneratedColumn<String>(
      'brewery', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, rating, thumbImageUrl, imageUrl, brewery];
  @override
  String get aliasedName => _alias ?? 'db_beer_table';
  @override
  String get actualTableName => 'db_beer_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbBeer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('thumb_image_url')) {
      context.handle(
          _thumbImageUrlMeta,
          thumbImageUrl.isAcceptableOrUnknown(
              data['thumb_image_url']!, _thumbImageUrlMeta));
    } else if (isInserting) {
      context.missing(_thumbImageUrlMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('brewery')) {
      context.handle(_breweryMeta,
          brewery.isAcceptableOrUnknown(data['brewery']!, _breweryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DbBeer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBeer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating'])!,
      thumbImageUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}thumb_image_url'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      brewery: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brewery']),
    );
  }

  @override
  $DbBeerTableTable createAlias(String alias) {
    return $DbBeerTableTable(attachedDatabase, alias);
  }
}

class DbBeer extends DataClass implements Insertable<DbBeer> {
  final String id;
  final String name;
  final int rating;
  final String thumbImageUrl;
  final String imageUrl;
  final String? brewery;
  const DbBeer(
      {required this.id,
      required this.name,
      required this.rating,
      required this.thumbImageUrl,
      required this.imageUrl,
      this.brewery});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['rating'] = Variable<int>(rating);
    map['thumb_image_url'] = Variable<String>(thumbImageUrl);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || brewery != null) {
      map['brewery'] = Variable<String>(brewery);
    }
    return map;
  }

  DbBeerTableCompanion toCompanion(bool nullToAbsent) {
    return DbBeerTableCompanion(
      id: Value(id),
      name: Value(name),
      rating: Value(rating),
      thumbImageUrl: Value(thumbImageUrl),
      imageUrl: Value(imageUrl),
      brewery: brewery == null && nullToAbsent
          ? const Value.absent()
          : Value(brewery),
    );
  }

  factory DbBeer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBeer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      rating: serializer.fromJson<int>(json['rating']),
      thumbImageUrl: serializer.fromJson<String>(json['thumbImageUrl']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      brewery: serializer.fromJson<String?>(json['brewery']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'rating': serializer.toJson<int>(rating),
      'thumbImageUrl': serializer.toJson<String>(thumbImageUrl),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'brewery': serializer.toJson<String?>(brewery),
    };
  }

  DbBeer copyWith(
          {String? id,
          String? name,
          int? rating,
          String? thumbImageUrl,
          String? imageUrl,
          Value<String?> brewery = const Value.absent()}) =>
      DbBeer(
        id: id ?? this.id,
        name: name ?? this.name,
        rating: rating ?? this.rating,
        thumbImageUrl: thumbImageUrl ?? this.thumbImageUrl,
        imageUrl: imageUrl ?? this.imageUrl,
        brewery: brewery.present ? brewery.value : this.brewery,
      );
  @override
  String toString() {
    return (StringBuffer('DbBeer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rating: $rating, ')
          ..write('thumbImageUrl: $thumbImageUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('brewery: $brewery')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, rating, thumbImageUrl, imageUrl, brewery);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBeer &&
          other.id == this.id &&
          other.name == this.name &&
          other.rating == this.rating &&
          other.thumbImageUrl == this.thumbImageUrl &&
          other.imageUrl == this.imageUrl &&
          other.brewery == this.brewery);
}

class DbBeerTableCompanion extends UpdateCompanion<DbBeer> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rating;
  final Value<String> thumbImageUrl;
  final Value<String> imageUrl;
  final Value<String?> brewery;
  const DbBeerTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rating = const Value.absent(),
    this.thumbImageUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.brewery = const Value.absent(),
  });
  DbBeerTableCompanion.insert({
    required String id,
    required String name,
    required int rating,
    required String thumbImageUrl,
    required String imageUrl,
    this.brewery = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        rating = Value(rating),
        thumbImageUrl = Value(thumbImageUrl),
        imageUrl = Value(imageUrl);
  static Insertable<DbBeer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rating,
    Expression<String>? thumbImageUrl,
    Expression<String>? imageUrl,
    Expression<String>? brewery,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rating != null) 'rating': rating,
      if (thumbImageUrl != null) 'thumb_image_url': thumbImageUrl,
      if (imageUrl != null) 'image_url': imageUrl,
      if (brewery != null) 'brewery': brewery,
    });
  }

  DbBeerTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? rating,
      Value<String>? thumbImageUrl,
      Value<String>? imageUrl,
      Value<String?>? brewery}) {
    return DbBeerTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      thumbImageUrl: thumbImageUrl ?? this.thumbImageUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      brewery: brewery ?? this.brewery,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (thumbImageUrl.present) {
      map['thumb_image_url'] = Variable<String>(thumbImageUrl.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (brewery.present) {
      map['brewery'] = Variable<String>(brewery.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBeerTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rating: $rating, ')
          ..write('thumbImageUrl: $thumbImageUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('brewery: $brewery')
          ..write(')'))
        .toString();
  }
}

class $DbBreweryTableTable extends DbBreweryTable
    with TableInfo<$DbBreweryTableTable, DbBrewery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBreweryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, address, city, country];
  @override
  String get aliasedName => _alias ?? 'db_brewery_table';
  @override
  String get actualTableName => 'db_brewery_table';
  @override
  VerificationContext validateIntegrity(Insertable<DbBrewery> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DbBrewery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBrewery(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
    );
  }

  @override
  $DbBreweryTableTable createAlias(String alias) {
    return $DbBreweryTableTable(attachedDatabase, alias);
  }
}

class DbBrewery extends DataClass implements Insertable<DbBrewery> {
  final String id;
  final String name;
  final String address;
  final String city;
  final String country;
  const DbBrewery(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      required this.country});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    return map;
  }

  DbBreweryTableCompanion toCompanion(bool nullToAbsent) {
    return DbBreweryTableCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      city: Value(city),
      country: Value(country),
    );
  }

  factory DbBrewery.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBrewery(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
    };
  }

  DbBrewery copyWith(
          {String? id,
          String? name,
          String? address,
          String? city,
          String? country}) =>
      DbBrewery(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country,
      );
  @override
  String toString() {
    return (StringBuffer('DbBrewery(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('country: $country')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, city, country);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBrewery &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.city == this.city &&
          other.country == this.country);
}

class DbBreweryTableCompanion extends UpdateCompanion<DbBrewery> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> city;
  final Value<String> country;
  const DbBreweryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
  });
  DbBreweryTableCompanion.insert({
    required String id,
    required String name,
    required String address,
    required String city,
    required String country,
  })  : id = Value(id),
        name = Value(name),
        address = Value(address),
        city = Value(city),
        country = Value(country);
  static Insertable<DbBrewery> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? country,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
    });
  }

  DbBreweryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? address,
      Value<String>? city,
      Value<String>? country}) {
    return DbBreweryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBreweryTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('country: $country')
          ..write(')'))
        .toString();
  }
}

abstract class _$BeerAppDatabase extends GeneratedDatabase {
  _$BeerAppDatabase(QueryExecutor e) : super(e);
  _$BeerAppDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $DbTodoTableTable dbTodoTable = $DbTodoTableTable(this);
  late final $DbBeerTableTable dbBeerTable = $DbBeerTableTable(this);
  late final $DbBreweryTableTable dbBreweryTable = $DbBreweryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dbTodoTable, dbBeerTable, dbBreweryTable];
}
