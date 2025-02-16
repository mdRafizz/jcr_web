import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/model/posts.dart';
import '../../../data/providers/api_service.dart';
import '../../../data/service/meta_service.dart';

class HomeController extends GetxController {
  @override
  void onInit() {

    MetaService.updateMetaTags(
      title: "Latest Job Circulars, Results & Notices in Bangladesh - Job Circular & Result",
      description: "Stay updated with the latest job circulars, exam results, and important notices from trusted sources. Your comprehensive platform for career preparation and government/private job updates in Bangladesh.",
      keywords: "job circulars, exam results, job notices, Bangladesh jobs, government jobs, career preparation",
      url: "https://jobcircularlive.com/",
    );


    box = GetStorage();
    if (kDebugMode) {
      // print(box.read('user'));
      print('User token: ${box.read('token')}');
    }
    fetchAllPosts();

    ever(selectedIndex, (_) => filterCirculars());

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  late GetStorage box;


  //সাইড মেনু সিলেক্ট করার জন্য
  var selectedIndex = 0.obs;

  void selectMenu(int index) {
    selectedIndex.value = index;
  }

  //সাইড মেনু হোভারের জন্য
  var hoveredIndex = (-1).obs;

  void hoverMenu(int index) {
    hoveredIndex.value = index;
  }


  //end সাইড মেনু হোভারের জন্য
  var endHoveredIndex = (-1).obs;

  void endHoverMenu(int index) {
    endHoveredIndex.value = index;
  }

  //সার্চ বারের জন্য
  var searchKeyword = ''.obs;

  //সার্চের জন্য
  void updateSearchKeyword(String? keyword) {
    if (keyword == null || keyword.isEmpty) {
      searchKeyword('');
    } else {
      searchKeyword(keyword);
    }
  }

  final postLists = <Posts>[].obs; // Observable list for notes
  var isLoading = false.obs; // Loading indicator

  var posts = [].obs;

  final ApiService _apiService = ApiService();

  void fetchAllPosts() async {
    try {
      isLoading(true); // লোডিং শুরু
      final fetchedPosts = await _apiService.fetchPosts();
      postLists.value = fetchedPosts; // ডেটা আপডেট
      posts.value = fetchedPosts; // ডেটা আপডেট
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading(false); // লোডিং শেষ
    }
  }

  void filterCirculars() {
    if (selectedIndex.value == 0) {
      posts.value = postLists.where((post) => true).toList();
    } else {
      posts.value = postLists
          .where((post) => post.category!.id == selectedIndex.value)
          .toList();
    }

    debugPrint('filterCirculars is called');
    debugPrint('Selected Index: ${selectedIndex.value}');
    debugPrint('Filtered Circulars: ${posts.length}');
  }

  // String formatDate(DateTime date) {
  //   return DateFormat('MMMM d, y').format(date);
  // }

}
