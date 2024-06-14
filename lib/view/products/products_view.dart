import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/view/products/components/category_product.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();

    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    _categories = productViewModel.getAllCategories();
    _categories.then((categories) {
      bool checkAll = categories.any((category) => category.id == 0);
      if (!checkAll) {
        categories.insert(0, Category(id: 0, name: "Tất cả"));
      }

      setState(() {
        _tabController = TabController(length: categories.length, vsync: this);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Category> categories = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Danh sách sản phẩm"),
              centerTitle: true,
              actions: [
                // IconButton(
                //   onPressed: () {
                //     showSearch(
                //       context: context,
                //       delegate: CustomSearchDelegate(),
                //     );
                //   },
                //   icon: const Icon(Icons.search),
                // ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.shopping_cart))
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabAlignment: TabAlignment.start,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: Colors.pink,
                    ),
                    isScrollable: true,
                    tabs: categories
                        .map((category) => Container(
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            child: Tab(text: category.name)))
                        .toList(),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                return CategoryProductsView(categoryId: category.id);
              }).toList(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Danh sách sản phẩm"),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
