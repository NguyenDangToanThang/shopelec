import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopelec/repository/auth_repository.dart';

class UploadAvatarProvider with ChangeNotifier {
  final _myRepo = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  File? _image;
  bool _isUploading = false;

  File? get image => _image;
  bool get isUploading => _isUploading;

  final picker = ImagePicker();

  Future<void> refreshUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload();
      notifyListeners();
    }
  }

  Future<bool?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> uploadImage() async {
    if (_image == null) return;
    _isUploading = true;
    notifyListeners();
    await _myRepo.uploadAvatar(_image!);
    await refreshUser();
    _isUploading = false;
    _image = null;
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }
}
