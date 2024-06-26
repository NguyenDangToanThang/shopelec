import 'package:flutter/material.dart';

class TermsPolicyScreen extends StatelessWidget {
  const TermsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khoản và Chính sách'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Chào mừng bạn đến với Shop Electronics',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Sự hài lòng của khách hàng',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Ưu tiên của chúng tôi là cung cấp cho bạn những sản phẩm công '
                'nghệ tốt nhất và dịch vụ đặc biệt. Nếu bạn có bất kỳ câu hỏi nào '
                'hoặc cần hỗ trợ, đội ngũ nhân viên thân thiện của chúng tôi luôn sẵn sàng trợ giúp.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Thông tin bảo hành',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Nhiều sản phẩm của chúng tôi được nhà sản xuất bảo hành.'
                'Vui lòng tham khảo tài liệu sản phẩm để biết thông tin bảo hành cụ thể.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Chính sách bảo mật',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Chúng tôi coi trọng quyền riêng tư của bạn và cam kết bảo vệ '
                'thông tin cá nhân của bạn. Vui lòng xem lại chính sách bảo mật '
                'đầy đủ trên trang web của chúng tôi để biết thêm chi tiết.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Liên hệ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Nếu bạn có câu hỏi hay vấn đề gì hãy liên hệ với chúng tôi qua '
                'email nvbb802@gmail.com hoặc gọi vào số (84) 387185045.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
