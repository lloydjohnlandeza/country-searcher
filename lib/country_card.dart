import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  String countryName;
  CountryCard({super.key, required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 0.6,
              child: Image.asset(
                'assets/images/flag.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontWeight: FontWeight.bold),
                      text: 'Population: ',
                      children: [
                        TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          text: '1000',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontWeight: FontWeight.bold),
                      text: 'Region: ',
                      children: [
                        TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          text: 'Ipsum',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontWeight: FontWeight.bold),
                      text: 'Capital: ',
                      children: [
                        TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          text: 'Lorem',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
