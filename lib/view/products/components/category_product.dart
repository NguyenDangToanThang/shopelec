
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class CategoryProductsView extends StatefulWidget {
  final int categoryId;

  const CategoryProductsView({super.key, required this.categoryId});

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends State<CategoryProductsView> {
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
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    if (widget.categoryId > 0) {
      List<Product> newProducts = await productViewModel.getAllProducts(
        categoryId: widget.categoryId,
        size: 20,
        page: page,
      );
      setState(() {
        products.addAll(newProducts);
        page++;
        isLoading = false;
      });
    } else {
      List<Product> newProducts =
          await productViewModel.getAllProducts(size: 20, page: page);
      setState(() {
        products.addAll(newProducts);
        page++;
        isLoading = false;
      });
    }
  }

  Future<void> _fetchMoreProducts() async {
    if (!isLoading) {
      await _fetchProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    products.clear();
    page = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
