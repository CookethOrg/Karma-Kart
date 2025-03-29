import 'dart:io';

import 'package:karmakart/core/services/image_services.dart';
import 'package:karmakart/core/utils/utils.dart';
import 'package:karmakart/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends StateHandler {
  late final SupabaseClient supabase;
  SupabaseService(this.supabase) : super();
  late AuthResponse _userData;
  bool _userDataSet = false;

  AuthResponse get userData => _userData;
  bool get userDataSet => _userDataSet;

  void setUserData(AuthResponse user) {
    _userData = user;
    _userDataSet = true;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchCurrentUserName() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      return null;
    }

    try {
      final response = await supabase
          .from('User')
          .select('name')
          .eq('id', user.id)
          .single();

      print("Fetched user name: $response");
      return response;
    } catch (e) {
      print("Error fetching user name: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchCurrentUserDetails() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      final response =
          await supabase.from('User').select().eq('id', user.id).single();

      print("Fetched user details: $response");
      return response;
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }

  Future<String> createNewUser({
    required String userName,
    required String email,
    required String password,
    required String name,
    // skills bhi daalne hoge
    required List<String> socialLinks,
    required String bio,
    required File imageFile,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && userName.isNotEmpty && password.isNotEmpty) {
        // Sign up user
        final AuthResponse authResponse = await supabase.auth.signUp(
          email: email,
          password: password,
          emailRedirectTo: null, // Disable email verification redirect
          data: {
            'userName': userName,
            'name': name,
          }, // Store username in metadata
        );

        final user = authResponse.user;
        setUserData(authResponse);
        print(user);

        if (user == null) throw Exception("User signup failed.");

        final newUser = UserModel(
          email: email,
          userName: userName,
          balance: 500,
          rating: 0,
          userBio: bio,
          socialLinks: socialLinks,
        );

        Map<String, String> links = {
          "1": socialLinks[0],
          "2": socialLinks[1],
          "3": socialLinks[2],
        };

        // insert data into user table
        await supabase.from('User').insert({
          'id': user.id,
          'userName': newUser.userName,
          'email': email,
          'name': name,
          'socialLinks': links,
          'services': {},
          'userBio': newUser.userBio,
          'userPrice': newUser.userPrice,
          'testimonials': {},
          'rating': newUser.rating,
          'projects': {},
          'balance': newUser.balance,
        });

        ImageServices(supabase).uploadImage(imageFile, user.id, true);

        res = "Signed Up Successfully";
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
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // 🛠 Attempt login
        final AuthResponse authResponse = await supabase.auth
            .signInWithPassword(email: email, password: password);

        final user = authResponse.user;

        if (user == null) {
          throw Exception('Login failed: User not found.');
        }

        // ✅ Store user data for future use
        setUserData(authResponse);

        res = 'Logged in successfully';
        print("✅ Login Successful! User ID: ${user.id}");
      } else {
        res = 'Email and Password cannot be empty';
      }
    } on AuthException catch (e) {
      res = 'Authentication error: ${e.message}';
      print("❌ AuthException: ${e.message}");
    } on PostgrestException catch (e) {
      res = 'Database error: ${e.message}';
      print("❌ PostgrestException: ${e.message}");
    } catch (e) {
      res = 'Unexpected error: ${e.toString()}';
      print("❌ Unexpected error: ${e.toString()}");
    }

    return res;
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Error logging out: ${e.toString()}');
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      // Delete user data from database first
      await supabase.from('User').delete().eq('id', user.id);

      // Then delete the auth account
      // await supabase.auth.admin.deleteUser(user.id);

      // Sign out
      await supabase.auth.signOut();
    } catch (e) {
      print("Error deleting account: $e");
      throw Exception('Error deleting account: ${e.toString()}');
    }
  }

  // Check if the user is already logged in
  Future<bool> checkUserSession() async {
    final user = supabase.auth.currentUser;
    return user != null;
  }

  // Update user name in both Auth and User table
  Future<String> updateUserName({required String userName}) async {
    String res = 'Some error occurred';

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      // Input validation
      if (userName.trim().isEmpty) {
        throw Exception('Username cannot be empty');
      }

      // Update username in Auth metadata
      await supabase.auth.updateUser(
        UserAttributes(data: {'userName': userName}),
      );

      // Also update username in User table
      await supabase
          .from('User')
          .update({'userName': userName})
          .eq('id', user.id);

      res = 'Username updated successfully';
      notifyListeners(); // Notify listeners of the change
      return res;
    } catch (e) {
      res = e.toString();
      throw Exception(res);
    }
  }

  // Update user email (would typically require email verification)
  Future<String> updateUserEmail({required String email}) async {
    String res = 'Some error occurred';

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      // Input validation
      if (email.trim().isEmpty) {
        throw Exception('Email cannot be empty');
      }

      // Basic email validation regex
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        throw Exception('Please enter a valid email address');
      }

      // Update email in Auth
      // Note: This would typically send a confirmation email
      await supabase.auth.updateUser(UserAttributes(email: email));

      // Also update email in User table
      await supabase.from('User').update({'email': email}).eq('id', user.id);

      res = 'Email update requested. Please check your inbox to confirm.';
      notifyListeners();
      return res;
    } catch (e) {
      res = e.toString();
      throw Exception(res);
    }
  }

  // Update user password
  Future<String> updateUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    String res = 'Some error occurred';

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      // Input validation
      if (newPassword.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Verify current password by attempting to sign in
      await supabase.auth.signInWithPassword(
        email: user.email!,
        password: currentPassword,
      );

      // Update the password
      await supabase.auth.updateUser(UserAttributes(password: newPassword));

      res = 'Password updated successfully';
      return res;
    } catch (AuthException) {
      res = 'Current password is incorrect';
      throw Exception(res);
    }
  }
}
