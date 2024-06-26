import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/detail.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/view/rate/components/rating_dialog.dart';
import 'package:shopelec/view_model/order_view_model.dart';

class RateProductScreen extends StatefulWidget {
  const RateProductScreen({super.key, required this.order});

  final Order order;

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  late Future<dynamic> details;

  @override
  void initState() {
    super.initState();

    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    details = orderViewModel.getAllOrderDetailByOrderId(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá sản phẩm'),
      ),
      body: FutureBuilder(
          future: details,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Detail> list = snapshot.data;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  String image = list[index].imageUrl;
                  String price = NumberFormat.currency(
                          locale: 'vi_VN', symbol: '₫', customPattern: '¤#,##0')
                      .format(((list[index].price -
                              list[index].price * list[index].discount / 100))
                          .toInt());
                  String name = list[index].name;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                image,
                                height: 80,
                                width: 80,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: price,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' x ${list[index].quantity}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      if (list[index].rate == false) {
                                        await showDialog(
                                          context: context,
                                          builder: (context) => RatingDialog(
                                              detail: list[index],
                                              orderId: widget.order.id),
                                        ).then((value) {
                                          setState(() {
                                            list[index] = list[index]
                                                .copyWith(rate: value);
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: list[index].rate
                                              ? Colors.grey
                                              : Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: list[index].rate
                                          ? const Text("Đã đánh giá")
                                          : const Text("Đánh giá"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
