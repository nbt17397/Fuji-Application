import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../views/auth_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;

  // Đăng ký người dùng mới
  Future<void> register(
      String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();
      isLoggedIn(true);
      Get.offAll(
          () => HomeView()); // Chuyển đến HomeView sau khi đăng ký thành công
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
    Get.offAll(
        () => AuthView()); // Quay lại màn hình đăng nhập sau khi đăng xuất
  }

  // Reset mật khẩu qua email
  Future<void> resetPassword(String email) async {
    isLoading(true); // Bắt đầu loading
    isSuccess(false); // Reset trạng thái success
    try {
      await auth.sendPasswordResetEmail(email: email);
      isSuccess(true); // Thành công
      Get.snackbar(
          "Success", "Password reset email sent! Please check your inbox.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false); // Kết thúc loading
    }
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

  void resetSuccessState() {
    isSuccess(false);
  }

  @override
  void onClose() {
    isSuccess(false); // Reset trạng thái khi màn hình bị đóng
    super.onClose();
  }
}
