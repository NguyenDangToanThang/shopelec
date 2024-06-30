import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view_model/product_view_model.dart';
import 'package:shopelec/view_model/store_view_model.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key, required this.name});

  final String name;

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Product> products = [];
  bool isLoading = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    _fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreProducts();
      }
    });
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    final storeViewModel = Provider.of<StoreViewModel>(context, listen: false);
    Category? category = storeViewModel.categories
        .firstWhere((element) => element.name == widget.name);
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<Product> newProducts = await productViewModel.getAllProducts(
        userId: userId, categoryId: category.id, size: 12, page: page);
    setState(() {
      products.addAll(newProducts);
      page++;
      isLoading = false;
    });
  }

  Future<void> _fetchMoreProducts() async {
    if (!isLoading) {
      await _fetchProducts();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.cart);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridProduct(products: products, length: products.length),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
