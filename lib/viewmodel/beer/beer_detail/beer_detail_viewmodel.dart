import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

@injectable
class BeerDetailViewModel with ChangeNotifierEx {
  final BeerWithBrewery beerWithBrewery;

  BeerDetailViewModel(this.beerWithBrewery);
}
