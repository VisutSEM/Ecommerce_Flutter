import 'package:e_commerce_flutter/app/core/features/auth/data/models/req/login_req.model.dart';
import 'package:e_commerce_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(text: "nessa@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "123123");

  final RxBool isHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                /// Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 95,
                        width: 95,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_person_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 45),

                /// Email Field
                _buildTextField(
                  controller: emailController,
                  hint: "Email Address",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }

                    if (!GetUtils.isEmail(value)) {
                      return "Invalid email address";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 22),

                /// Password Field
                Obx(
                  () => _buildTextField(
                    controller: passwordController,
                    hint: "Password",
                    icon: Icons.lock_outline_rounded,
                    isPassword: isHidden.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        isHidden.value = !isHidden.value;
                      },
                      icon: Icon(
                        isHidden.value
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }

                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 15),

                /// Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// Login Button
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {

                          final req = LoginReq(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          final success = await controller.login(req);

                          if (success) {
                            Get.snackbar(
                              "Success",
                              "Login Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            Get.offAllNamed('/main-app');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                 SizedBox(height: 35),

                /// Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 30),

                /// Google Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/281/281764.png",
                      height: 22,
                    ),
                    label: const Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                /// Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
        ),
      ),
    );
  }
}
