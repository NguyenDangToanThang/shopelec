import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view_model/product_view_model.dart';
import 'package:shopelec/view_model/store_view_model.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  int selectedCategory = 0;
  int selectedBrand = 0;
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
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<Product> newProducts = await productViewModel.getAllProducts(
      userId: userId,
      brandId: selectedBrand,
      categoryId: selectedCategory,
      size: 20,
      page: page,
    );
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
    _scrollController.dispose();
    products.clear();
    page = 0;
    super.dispose();
  }

  void _onCategorySelected(int categoryId) {
    setState(() {
      selectedCategory = categoryId;
      products.clear();
      page = 0;
      _fetchProducts();
    });
  }

  void _onBrandSelected(int brandId) {
    setState(() {
      selectedBrand = brandId;
      products.clear();
      page = 0;
      _fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeViewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        titleSpacing: 0.5,
        title: Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: storeViewModel.categories.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      storeViewModel.categories[index].id == selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      _onCategorySelected(storeViewModel.categories[index].id);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Center(
                        child: Text(
                          storeViewModel.categories[index].name,
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected ? Colors.white : Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: storeViewModel.brands.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      storeViewModel.brands[index].id == selectedBrand;
                  return GestureDetector(
                    onTap: () {
                      _onBrandSelected(storeViewModel.brands[index].id);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Center(
                          child: Text(
                        storeViewModel.brands[index].name,
                        style: TextStyle(
                          fontSize: 15,
                          color: isSelected ? Colors.white : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  );
                },
              ),
            ),
            if (products.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text("Không có sản phẩm nào")),
              )
            else
              GridProduct(
                products: products,
                length: products.length,
              ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text("Đang tải ...")),
              ),
          ],
        ),
      ),
    );
  }
}
