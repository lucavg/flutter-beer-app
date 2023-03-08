import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:flutter/material.dart';

class BeerDetailScreen extends StatefulWidget {
  static const String routeName = RouteNames.beerDetailScreen;
  final BeerWithBrewery beerWithBrewery;

  const BeerDetailScreen({super.key, required this.beerWithBrewery});

  @override
  BeerDetailScreenState createState() => BeerDetailScreenState();
}

@visibleForTesting
class BeerDetailScreenState extends State<BeerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beerWithBrewery.beer.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),

              /// This is the important part, we need [Hero] widget with unique tag but same as Hero's tag in [User] widget.
              child: Hero(
                tag: "avatar_${widget.beerWithBrewery.beer.id}",
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(widget.beerWithBrewery.beer.imageUrl),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(ThemeDimens.padding32),
                child: Column(children: [
                  Text(
                    widget.beerWithBrewery.beer.name,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    "${widget.beerWithBrewery.beer.rating}/5",
                  ),
                  const Text("Brewery:"),
                  Text(widget.beerWithBrewery.brewery!.name),
                  Text('Address: ${widget.beerWithBrewery.brewery!.address}'),
                  Text(widget.beerWithBrewery.brewery!.city),
                  Text(widget.beerWithBrewery.brewery!.country),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
