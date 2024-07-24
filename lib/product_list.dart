import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});
  @override
  State<ProductList> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = ['All', 'Adidas', 'Nike', 'Bata', 'Buma'];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Shoes\nCollection',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: border,
                        enabledBorder: border,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Chip(
                          side: BorderSide.none,
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : Colors.lightBlue.shade200,
                          label: Text(filter),
                          labelStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetails(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : Colors.lightBlue.shade200,
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                      ),
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
