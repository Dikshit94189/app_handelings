import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_tasks/view_model/quote_view.dart';
import 'package:provider/provider.dart';

import '../utils/api_response.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<QuoteViewModel>(context , listen: false).getRandomQuote());
  }


  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

        Stack(
        children: [

        /// 🔹 Background Image
        SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl:
          "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1200",
          fit: BoxFit.cover,
          placeholder: (context,url)=>Center(
            child: CupertinoActivityIndicator(radius: 16,color: Colors.blue),
          ),
        ),
      ),

      Positioned(
          top: 10,
          left: 10,right: 10,
          child: Consumer<QuoteViewModel>(
              builder: (context , viewModel , child){
                switch (viewModel.quoteResponse.status){
                  case Status.loading:
                    return CupertinoActivityIndicator();

                  case Status.complete:
                    final quote = viewModel.quoteResponse.data;
                    return Text(quote!.quote , style: TextStyle(color: Colors.purple ,fontWeight: FontWeight.bold, fontSize: 22));


                  case Status.error:
                    return Text("Error");
                }
              },
              )),

      /// 🔹 Bottom ListView Positioned on Image
      Positioned(
        bottom:25,
        left: 20,
        right: 0,
        child: Container(
          height: 250,
          // color: Colors.black.withOpacity(0.6),
          color: Colors.transparent,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                margin: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Item ${index + 1}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      ],
    ),


          ],
        ),
      ),
    );
  }
}
