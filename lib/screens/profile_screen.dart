import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/api_response.dart';
import '../view_model/quote_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<QuoteViewModel>();

      viewModel.getRandomImages();   // 🔥 YOU MISSED THIS
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Consumer<QuoteViewModel>(
          builder: (context , viewModel , child){
            switch(viewModel.imagesResponse.status){
              case Status.loading:
                return CupertinoActivityIndicator();
              case Status.complete:
                final images = viewModel.imagesResponse.data;

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length,
                    itemBuilder: (context, index) {
                      final image = images[index];

                      return Container(
                        width: 250,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: image.downloadUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image),
                          ),
                        ),
                      );
                    },
                  ),
                );
              case Status.error:
                return Text("Error");

            }

          },
        ),
      ],)),
    );
  }
}
