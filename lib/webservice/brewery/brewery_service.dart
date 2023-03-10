import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery_response.dart';

abstract class BreweryService {
  Future<BreweryResponse> getAllBreweries();
  Future<Brewery> getBrewery(String id);
}