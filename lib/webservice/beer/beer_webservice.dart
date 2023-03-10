import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/beer_response.dart';
import 'package:beer_app/webservice/beer/beer_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'beer_webservice.g.dart';

@dev
@prod
@Singleton(as: BeerService)
@RestApi()
abstract class BeerWebService extends BeerService {
  @factoryMethod
  factory BeerWebService(Dio dio) = _BeerWebService;

  @override
  @GET('/beers')
  Future<BeerResponse> getAllBeers();

  @override
  @GET('/beers/{beerId}')
  Future<Beer> getBeer(String id);

  @override
  @PUT('/beers/{beerId}')
  Future<void> saveBeer(int rating);
}