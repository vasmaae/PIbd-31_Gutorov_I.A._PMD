import 'package:flutter/material.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';

class DetailsPage extends StatelessWidget {
  final BookData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Image.network(data.imageUrl ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              data.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Text(
            data.author,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
