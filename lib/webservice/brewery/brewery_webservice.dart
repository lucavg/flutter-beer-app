import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery_response.dart';
import 'package:beer_app/webservice/brewery/brewery_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'brewery_webservice.g.dart';

@dev
@prod
@Singleton(as: BreweryService)
@RestApi()
abstract class BreweryWebService extends BreweryService {
  @factoryMethod
  factory BreweryWebService(Dio dio) = _BreweryWebService;

  @override
  @GET('/breweries')
  Future<BreweryResponse> getAllBreweries();

  @override
  @GET('/breweries/{breweryId}')
  Future<Brewery> getBrewery(String id);
}
