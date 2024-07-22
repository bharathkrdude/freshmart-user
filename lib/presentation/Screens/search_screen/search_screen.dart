import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/presentation/screens/products_screen/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val.toLowerCase();
                    print(inputText);
                  });
                },
                onFieldSubmitted: (val) {
                  // Trigger the search here
                  // You can call your search function here or dispatch a bloc event.
                },
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .where("name", isGreaterThanOrEqualTo: inputText)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No search results found"),
                      );
                    }

                    return ListView(
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        final Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        final ProductModel product =
                            ProductModel.fromJson(data);
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                            title: Text(product.name),
                            leading: Image.network(product.imageUrls[0]),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
