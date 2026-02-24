import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/api_response.dart';
import '../view_model/quote_view.dart';
import 'home_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     HomeScreen(),
//     HomeScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App")), // common appbar
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

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
                        child: image.url != null && image.url!.isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: image.thumbnailUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) {
                            print("Image load error: $error");
                            print("Failed URL: $url");
                            return const Icon(Icons.error, color: Colors.red);
                          },
                        )
                            : const Icon(Icons.image_not_supported),
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
