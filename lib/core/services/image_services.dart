import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/core/utils/state_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageServices extends StateHandler {
  SupabaseClient supabaseClient;
  ImageServices(this.supabaseClient);

  bool _isUploading = false;
  String? _imageUrl;

  bool get isUploading => _isUploading;
  String? get imageUrl => _imageUrl;

  void setLoading(bool val) {
    _isUploading = val;
    notifyListeners();
  }

  void updateUrl(String url) {
    if (_imageUrl != url) {
      _imageUrl = url;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(String imageUrl) async {
    // Get current user id
    final userId = supabaseClient.auth.currentUser?.id;

    if (userId != null) {
      // Update the user profile in the profiles table
      await supabaseClient
          .from('profiles')
          .update({'avatar_url': imageUrl})
          .eq('id', userId);
    }
  }

  Future<void> insertUserProfile(String? imageUrl) async {
    // Get current user id
    final userId = supabaseClient.auth.currentUser?.id;

    if (userId != null) {
      // Update the user profile in the profiles table
      await supabaseClient
          .from('profiles')
          .insert({'avatar_url': imageUrl})
          .eq('id', userId);
    }
  }

  Future<void> uploadImage(File imageFile, String userId, bool isSignup) async {
    setLoading(true);

    try {
      final fileExt = path.extension(imageFile.path);
      final fileName = '$userId$fileExt';

      // Upload the file to Supabase Storage
      final response = await supabaseClient.storage
          .from('profile_pictures') // bucket name
          .upload(
            'public/$userId/$fileName', // path inside bucket
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      // Get the public URL
      final imageUrlResponse = supabaseClient.storage
          .from('profile_pictures')
          .getPublicUrl('public/$userId/$fileName');

      updateUrl(imageUrlResponse);
      setLoading(false);

      // Optionally update user profile in database with this URL
      isSignup
          ? await updateUserProfile(_imageUrl!)
          : insertUserProfile(_imageUrl);
    } catch (error) {
      error.toString();
    }
  }
}
