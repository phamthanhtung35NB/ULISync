import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<String?> login(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential.user?.uid;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       return 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       return 'Wrong password provided.';
  //     } else {
  //       return 'An error occurred. Please try again.';
  //     }
  //   }
  // }
  Future<String?> login(String email, String password) async {
    if (!email.endsWith('@vnu.edu.vn')) {
      return 'Invalid email format. Please use your @vnu.edu.vn email.';
    }
    String username = email.split('@')[0];
    // return 'username: $username password: $password';
    if (password==username) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user?.uid;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          return 'Thông tin tài khoản hoặc mật khẩu không chính xác.';
        } else if (e.code == 'weak-password') {
          return 'Mật khẩu cung cấp quá yếu.';
        } else {
          return 'Đã xảy ra lỗi: ${e.message}';
        }
        // if (e.code == 'weak-password') {
        //   return 'Mật khẩu cung cấp quá yếu.';
        // } else if (e.code == 'email-already-in-use') {
        //   return 'Tài khoản email đó đã tồn tại.';
        // } else {
        //   return 'Đã xảy ra lỗi: ${e.message}';
        // }
      } catch (e) {
        return 'Đã xảy ra lỗi. Vui lòng thử lại: ${e.toString()}';
      }
    }
    else {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user?.uid;
        //không đăng nhập được
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return 'Không tìm thấy người dùng cho email đó.';
        } else if (e.code == 'wrong-password') {
          return 'Mật khẩu cung cấp không chính xác.';
        } else {
          return 'Đã xảy ra lỗi. Vui lòng thử lại: ${e.message}';
        }
      } catch (e) {
        return 'Đã xảy ra lỗi. Vui lòng thử lại: ${e.toString()}';
      }
    }

  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}