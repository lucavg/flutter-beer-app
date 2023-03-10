import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/beer_response.dart';

abstract class BeerService {
  Future<BeerResponse> getAllBeers();
  Future<Beer> getBeer(String id);
  Future<void> saveBeer(int rating);
}