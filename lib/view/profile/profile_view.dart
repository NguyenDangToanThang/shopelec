import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:intl/intl.dart';

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
      'Chọn giới tính',
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

  Future<void> _selectDate() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          dob = DateFormat("dd/MM/yyyy").format(value).toString();
          Map dataUpdate = {
            'id': FirebaseAuth.instance.currentUser!.uid,
            'email': FirebaseAuth.instance.currentUser!.email,
            'phoneNumber': phoneNumber,
            'gender': gender,
            'dob': dob,
            'name': FirebaseAuth.instance.currentUser!.displayName
          };
          authViewModel.updateUser(dataUpdate).whenComplete(() {
            Utils.flushBarSuccessMessage(
                "Cập nhật ngày sinh thành công", context);
          }).onError((error, stackTrace) =>
              Utils.flushBarErrorMessage(error.toString(), context));
        });
      }
    });
  }

  // String dateString = "14/06/2024"; // Example date string
  // DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  // DateTime dateTime = dateFormat.parse(dateString);

  // // If you want to print just the date part in the same format
  // String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);

  String gender = "";
  String dob = "";
  String phoneNumber = "";

  late Future<dynamic> _data;

  final logger = Logger();

  @override
  void initState() {
    super.initState();
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    String? id = FirebaseAuth.instance.currentUser!.uid;
    _data = authViewModel.getInfomation(id);
    _data.then((value) {
      setState(() {
        gender = value["gender"] ?? "Chọn giới tính";
        dob = value["dob"] ?? "";
        phoneNumber = value["phoneNumber"] ?? "";
      });
    });
  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final data = authViewModel.user;
    String name = data!.displayName ?? "";
    String id = data.uid;

    String email = data.email ?? "";
    DateTime dateCreated = data.metadata.creationTime!;
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateCreated);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hồ sơ"),
      ),
      body: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            return SingleChildScrollView(
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
                              Clipboard.setData(ClipboardData(text: email))
                                  .then((_) {
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
                                  context, "Tên người dùng", name, email);
                              _textFieldController.value =
                                  TextEditingValue(text: result ?? "");
                              if (result != null) {
                                Map dataUpdate = {
                                  'id': id,
                                  'email': email,
                                  'phoneNumber': phoneNumber,
                                  'gender': gender,
                                  'dob': dob,
                                  'name': result
                                };
                                authViewModel
                                    .updateUser(dataUpdate)
                                    .whenComplete(() {
                                  setState(() {
                                    name = result;
                                    authViewModel
                                        .setUser(FirebaseAuth.instance);
                                  });
                                  Utils.flushBarSuccessMessage(
                                      "Cập nhật thành công tên người dùng thành công",
                                      context);
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
                          formattedDate,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 64,
                        ),
                        // const Icon(Icons.chevron_right)
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Text(
                            id,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: id))
                                  .then((_) {
                                Utils.flushBarCopyMessage(
                                    "Mã người dùng đã được sao chép vào bộ nhớ tạm",
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
                              // await _showTextInputDialog(context,
                              //     "Adjust phone number", phoneNumber, email);

                              String? result = await _showTextInputDialog(
                                  context, "Số điện thoại", phoneNumber, email);
                              if (result != null) {
                                Map dataUpdate = {
                                  'id': id,
                                  'email': email,
                                  'phoneNumber': result,
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
                                      "Cập nhật số điện thoại thành công",
                                      context);
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
                              // await _showTextInputDialog(
                              //     context, "Select your gender", gender, email);
                              String? result =
                                  await _showTextInputDialogDropDown(
                                      context, "Chọn giới tính", gender);
                              if (result != null) {
                                Map dataUpdate = {
                                  'id': id,
                                  'email': email,
                                  'phoneNumber': phoneNumber,
                                  'date_created': dateCreated,
                                  'gender':
                                      result == "Chọn giới tính" ? "" : result,
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
                        InkWell(
                            onTap: _selectDate,
                            child: const Icon(Icons.chevron_right))
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      height: 3,
                    ),
                    SwitchListTile(
                      title: const Text('Ủy quyền sinh trắc học'),
                      value: authViewModel.isBiometricEnabled,
                      onChanged: (newValue) async {
                        // check = newValue;
                        // authViewModel.toggleBiometric(newValue);
                        if (newValue == false) {
                          authViewModel.toggleBiometric(newValue);
                        } else {
                          bool authenticated =
                              await authViewModel.authenticate();
                          if (authenticated) {
                            authViewModel.toggleBiometric(newValue);
                          } else {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Xác thực thất bại')),
                            // );
                          }
                        }
                      },
                    ),
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
                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "Đổi mật khẩu",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
            );
          }),
    );
  }
}
