import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _textFieldController = TextEditingController();

  Future<String?> _showTextInputDialog(
      BuildContext context, String title, String value, String email) async {
    // _textFieldController.clear();
    _textFieldController.value = TextEditingValue(text: value);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            title: Text(title),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.black, style: BorderStyle.solid),
              )),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white38))),
                child: const Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white38))),
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context, _textFieldController.text);
                },
              ),
            ],
          );
        });
  }

  Future<String?> _showTextInputDialogDropDown(
      BuildContext context, String title, String value) async {
    _textFieldController.clear();
    _textFieldController.value = TextEditingValue(text: value);

    String dropdowns = value;
    final logger = Logger();

    var items = [
      'Nam',
      'Nữ',
      'Khác',
    ];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            title: Text(title),
            content: DropdownButtonFormField(
              value: dropdowns,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdowns = newValue!;
                  _textFieldController.value =
                      TextEditingValue(text: dropdowns);
                  logger.i(_textFieldController.value.text);
                });
              },
              decoration: const InputDecoration(
                  labelText: "Chọn giới tính",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white38))),
                child: const Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white38))),
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () =>
                    Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    Map data = authViewModel.infoUserCurrent;
    String name = data['name'] ?? "";
    String id = data['id'].toString();
    String phoneNumber = data['phoneNumber'] ?? "";
    String email = data['email'];
    String dateCreated = data['date_created'];
    String gender = data['gender'] ?? "";
    String dob = data['dob'] ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hồ sơ"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 20.0, left: 20.0, top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Thông tin hồ sơ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    email,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: email)).then((_) {
                          Utils.flushBarCopyMessage(
                              "Địa chỉ email của bạn đã được sao chép vào bộ nhớ tạm",
                              context);
                        });
                      },
                      child: const Icon(Iconsax.copy))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tên người dùng",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    name,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                      onTap: () async {
                        String? result = await _showTextInputDialog(
                            context, "Thay đổi tên người dùng", name, email);
                        _textFieldController.value =
                            TextEditingValue(text: result ?? "");
                        if (result != null) {
                          Map dataUpdate = {
                            'id': id,
                            'email': email,
                            'phoneNumber': phoneNumber,
                            'date_created': dateCreated,
                            'gender': gender,
                            'dob': dob,
                            'name': result
                          };
                          authViewModel
                              .updateUser(dataUpdate)
                              .whenComplete(() {
                            setState(() {
                              name = result;
                            });
                            Utils.flushBarSuccessMessage(
                                "Cập nhật thành công tên người dùng thành công", context);
                          }).onError((error, stackTrace) =>
                                  Utils.flushBarErrorMessage(
                                      error.toString(), context));
                        }
                      },
                      child: const Icon(Icons.chevron_right))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ngày đăng ký",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    dateCreated,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                "Thông tin người dùng",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mã người dùng",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    id,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: id)).then((_) {
                          Utils.flushBarCopyMessage(
                              "Mã người dùng đã được sao chép vào bộ nhớ tạm", context);
                        });
                      },
                      child: const Icon(Iconsax.copy))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Số điện thoại",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    phoneNumber,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                      onTap: () async {
                        // await _showTextInputDialog(context,"Adjust phone number", phoneNumber,email);

                        String? result = await _showTextInputDialog(
                            context, "Thay đổi số điện thoại", phoneNumber, email);
                        if (result != null) {
                          Map dataUpdate = {
                            'id': id,
                            'email': email,
                            'phoneNumber': result,
                            'date_created': dateCreated,
                            'gender': gender,
                            'dob': dob,
                            'name': name
                          };
                          authViewModel
                              .updateUser(dataUpdate)
                              .whenComplete(() {
                            setState(() {
                              phoneNumber = result;
                            });
                            Utils.flushBarSuccessMessage(
                                "Cập nhật số điện thoại thành công", context);
                          }).onError((error, stackTrace) =>
                                  Utils.flushBarErrorMessage(
                                      error.toString(), context));
                        }
                      },
                      child: const Icon(Icons.chevron_right))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giới tính",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    gender,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                      onTap: () async {
                        // await _showTextInputDialog(context, "Select your gender", gender);
                        String? result = await _showTextInputDialogDropDown(
                            context, "Chọn giới tính", gender);
                        if (result != null) {
                          Map dataUpdate = {
                            'id': id,
                            'email': email,
                            'phoneNumber': phoneNumber,
                            'date_created': dateCreated,
                            'gender': result,
                            'dob': dob,
                            'name': name
                          };
                          authViewModel
                              .updateUser(dataUpdate)
                              .whenComplete(() {
                            setState(() {
                              gender = result;
                            });
                            Utils.flushBarSuccessMessage(
                                "Cập nhật giới tính thành công", context);
                          }).onError((error, stackTrace) =>
                                  Utils.flushBarErrorMessage(
                                      error.toString(), context));
                        }
                      },
                      child: const Icon(Icons.chevron_right))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ngày sinh",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 53,
                  ),
                  Text(
                    dob,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 3,
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    "Khóa tài khoản",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
