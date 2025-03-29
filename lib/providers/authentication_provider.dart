import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/core/utils/state_handler.dart';

class AuthenticationProvider extends StateHandler {
  final SupabaseService supabaseService;
  int _pageIndex = 0;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _skillsController = TextEditingController();
  final _link1Controller = TextEditingController();
  final _link2Controller = TextEditingController();
  final _link3Controller = TextEditingController();
  final _bioController = TextEditingController();
  File? _image; // To store the selected image
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  bool _isPasswordVisible = false;

  AuthenticationProvider(this.supabaseService) : super();

  // Getters
  int get pageIndex => _pageIndex;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get skillsController => _skillsController;
  TextEditingController get link1Controller => _link1Controller;
  TextEditingController get link2Controller => _link2Controller;
  TextEditingController get link3Controller => _link3Controller;
  TextEditingController get bioController => _bioController;
  File? get image => _image;
  ImagePicker get picker => _picker;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;

  void updatePageIndex(int val) {
    if (_pageIndex != val) {
      _pageIndex = val;
      notifyListeners();
    }
  }

  void setPasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<String> createNewUser({
    required String userName,
    required String email,
    required String password,
    required String name,
    required List<String> socialLinks,
    required String bio,
    // required File imageFile,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty &&
          userName.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          socialLinks.isNotEmpty &&
          bio.isNotEmpty) {
        res = await supabaseService.createNewUser(
          // imageFile: imageFile,
          userName: userName,
          email: email,
          password: password,
          name: name,
          socialLinks: socialLinks,
          bio: bio,
        );
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        res = await supabaseService.loginUser(email: email, password: password);
        // res = 'logged in';
      } else {
        res = 'Email and Password cannot be empty';
      }
    } catch (e) {
      res = 'Unexpected error: ${e.toString()}';
      print("❌ Unexpected error during login: ${e.toString()}");
    } finally {
      setLoading(false);
    }

    return res;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _skillsController.dispose();
    _link1Controller.dispose();
    _link2Controller.dispose();
    _link3Controller.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
