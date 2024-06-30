import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
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
  final TextEditingController _searchController = TextEditingController();
  List<Product> products = [];
  bool isLoading = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    _fetchProducts("");

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreProducts();
      }
    });
  }

  Future<void> _fetchProducts(String? query) async {
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
      size: 12,
      query: query,
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
      await _fetchProducts(_searchController.text.trim());
    }
  }

  void _onCategorySelected(int categoryId) {
    setState(() {
      selectedCategory = categoryId;
      products.clear();
      page = 0;
      _fetchProducts(_searchController.text.trim());
    });
  }

  void _onBrandSelected(int brandId) {
    setState(() {
      selectedBrand = brandId;
      products.clear();
      page = 0;
      _fetchProducts(_searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    products.clear();
    page = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeViewModel = Provider.of<StoreViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm sản phẩm',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              setState(() {
                products.clear();
                page = 0;
                _fetchProducts(value);
              });
            },
          ),
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
                        _onCategorySelected(
                            storeViewModel.categories[index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            storeViewModel.categories[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400,
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
                            horizontal: 6.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                            child: Text(
                          storeViewModel.brands[index].name,
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                      ),
                    );
                  },
                ),
              ),
              if (products.isEmpty && !isLoading)
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
      ),
    );
  }
}
