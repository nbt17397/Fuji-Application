import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../views/auth_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoggedIn = false.obs;
  var isLoading = false.obs;

  // Đăng ký người dùng mới
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      isLoggedIn(true);
      Get.offAll(() => HomeView()); // Chuyển đến HomeView sau khi đăng ký thành công
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Đăng nhập người dùng
  void login(String email, String password) async {
    isLoading.value = true; // Bắt đầu trạng thái loading
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn(true);
      Get.offAll(() => HomeView());
    } catch (e) {
      Get.snackbar("Error", e.toString());
      // Xử lý lỗi
    } finally {
      isLoading.value = false; // Kết thúc trạng thái loading
    }
  }

  // Đăng xuất người dùng
  Future<void> logout() async {
    await auth.signOut();
    isLoggedIn(false);
    Get.offAll(() => AuthView()); // Quay lại màn hình đăng nhập sau khi đăng xuất
  }

  // Kiểm tra trạng thái người dùng
  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn(true);
        Get.offAll(() => HomeView());
      } else {
        isLoggedIn(false);
      }
    });
  }
}
