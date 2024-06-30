import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/order/components/card_order.dart';
import 'package:shopelec/view_model/order_view_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn mua'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.cart);
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Chờ duyệt'),
            Tab(text: 'Chờ giao'),
            Tab(text: 'Đã giao'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderTabContent(status: 'Chờ duyệt', tabController: _tabController),
          OrderTabContent(
              status: 'Chờ giao hàng', tabController: _tabController),
          OrderTabContent(status: 'Đã giao', tabController: _tabController),
          OrderTabContent(status: 'Đã hủy', tabController: _tabController),
        ],
      ),
    );
  }
}

class OrderTabContent extends StatelessWidget {
  final String status;
  final TabController tabController;

  const OrderTabContent(
      {super.key, required this.status, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: orderViewModel.getOrdersByUserIdAndStatus(status),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Order> list = snapshot.data;
                  if (list.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                        Text('Chưa có đơn hàng',
                            style: TextStyle(color: Colors.grey))
                      ],
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            final order = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.detailOrder,
                                    arguments: order);
                              },
                              child: OrderCard(
                                order: order,
                                tabController: tabController,
                              ),
                            );
                          })),
                    );
                  }
                } else {
                  return const Center(child: Text('Đang tải...'));
                }
              })),
        ],
      ),
    );
  }
}
